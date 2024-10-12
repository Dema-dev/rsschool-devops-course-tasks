# EC2 Bastion-host
resource "aws_instance" "Bastion-Host" {

  ami           = "ami-0084a47cc718c111a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnets[0].id
  key_name = "${var.aws_key_name}"

  # Security group ID's
  vpc_security_group_ids = [aws_security_group.Bastion-host.id]
  tags = {
    Name = "Bastion_Host_From_Terraform"
  }
}

#EC2 Private Host
resource "aws_instance" "Private-Host" {

  ami           = "ami-0084a47cc718c111a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnets[0].id
  key_name = "${var.aws_key_name}"


  # Security group ID's
  vpc_security_group_ids = [aws_security_group.Private-host.id]
  tags = {
    Name = "Private_Host_From_Terraform"
  }
}