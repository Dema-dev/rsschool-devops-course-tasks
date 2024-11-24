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
    icmp_type  = -1
    icmp_code  = -1
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
    protocol   = -1
    rule_no    = 20
    action     = "allow"
    cidr_block = "192.168.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Public_acl ${count.index + 1}"
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
    icmp_type  = -1
    icmp_code  = -1
  }

  ingress {
    protocol   = -1
    rule_no    = 10
    action     = "allow"
    cidr_block = "192.168.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Private_acl ${count.index + 1}"
  }
}