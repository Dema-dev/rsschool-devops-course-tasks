resource "aws_vpc" "underground" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Project VPC Terra"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.underground.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true


  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.underground.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.underground.id

  tags = {
    Name = "Created VPC IG"
  }

}


# create Route table for Public subnets and associate it
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.underground.id

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  gateway_id             = aws_internet_gateway.gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# create Route table for Private subnets and associate it
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.underground.id

  count = length(var.PrivateRoute)

  tags = {
    Name = element(var.PrivateRoute, count.index)
  }
}

resource "aws_route" "private_route" {
  count                  = length(var.PrivateRoute)
  route_table_id         = element(aws_route_table.private_rt[*].id, count.index)
  nat_gateway_id         = element(aws_nat_gateway.nat_gt[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = element(aws_route_table.private_rt[*].id, count.index)
}



resource "aws_eip" "Nat-Gateway-Elastic-IP" {
  count      = length(var.public_subnet_cidrs)
  depends_on = [aws_route_table_association.public_subnet_asso]
}

resource "aws_nat_gateway" "nat_gt" {
  count         = length(var.public_subnet_cidrs)
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  allocation_id = element(aws_eip.Nat-Gateway-Elastic-IP[*].id, count.index)
  depends_on    = [aws_internet_gateway.gw]

  tags = {
    Name = "NAT GT"
  }
}
