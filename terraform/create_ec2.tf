resource "aws_instance" "Bastion-Host" {

  ami = "ami-0162dd7febeafb455"
  instance_type = "t2.micro"
  count         = length(var.public_subnet_cidrs)
  subnet_id = element(aws_subnet.public_subnets[1].id, count.index)
   
  # Security group ID's
  vpc_security_group_ids = [aws_security_group.Bastion-host.id]
  tags = {
   Name = "Bastion_Host_From_Terraform"
  }
}