resource "aws_instance" "my_ubuntu" {
    ami = "ami-0e04bcbe83a83792e"
    instance_type = "t2.micro"
    
    tags = {
        Name = "Ubuntu"
        Owner = "Demian"
        Project = "First use Terraform"

    }
  
} 

resource "aws_instance" "myAmazonLinux" {
    ami = "ami-00f07845aed8c0ee7"
    instance_type = "t2.micro"

    tags = {
        Name = "AmazonLinux"
        Owner = "Demian"
        Project = "First use Terraform"

    }
  
} 