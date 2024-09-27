resource "aws_instance" "my_ubuntu" {
    ami = "ami-0e86e20dae9224db8"
    instance_type = "t3.micro"
    
    tags = {
        Name = "Ubuntu"
        Owner = "Demian"
        Project = "First use Terraform"

    }
  
} 

resource "aws_instance" "myAmazonLinux" {
    ami = "ami-0ebfd941bbafe70c6"
    instance_type = "t3.small"

    tags = {
        Name = "AmazonLinux"
        Owner = "Demian"
        Project = "First use Terraform"

    }
  
} 