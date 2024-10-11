resource "aws_security_group" "Bastion-host" {
  depends_on = [aws_vpc.underground, aws_subnet.public_subnets]

  description = "Access to internal recources from allowed server"
  name        = "bastion-host"
  vpc_id      = aws_vpc.underground.id

  ingress = {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ping"
    from_port   = 0
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "output from Bastion Host"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}