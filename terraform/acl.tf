resource "aws_network_acl" "public_acl" {
  vpc_id     = aws_vpc.underground.id
  count      = length(var.public_subnet_cidrs)
  subnet_ids = [element(aws_subnet.public_subnets[*].id, count.index)]

  egress {
    protocol   = -1
    rule_no    = 1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "icmp"
    rule_no    = 5
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 10
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "udp"
    rule_no    = 20
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }



  tags = {
    Name = "public_acl"
  }
}


resource "aws_network_acl" "private_acl" {
  vpc_id     = aws_vpc.underground.id
  count      = length(var.private_subnet_cidrs)
  subnet_ids = [element(aws_subnet.private_subnets[*].id, count.index)]

  egress {
    protocol   = -1
    rule_no    = 1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "icmp"
    rule_no    = 5
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 10
    action     = "allow"
    cidr_block = var.public_subnet_cidrs[0]
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 11
    action     = "allow"
    cidr_block = var.public_subnet_cidrs[1]
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "udp"
    rule_no    = 20
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }


  tags = {
    Name = "private_acl"
  }
}