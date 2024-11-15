data "aws_ami" "ubuntu_24_04" {
    owners = ["099720109477"] # Official Ubuntu owner ID
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }

}

output "ubuntu_ami_id" {
    value = data.aws_ami.ubuntu_24_04.id 
    description = "ID of AWS AMI for ubuntu 24.04"
}

output "ubuntu_ami_name" {
    value = data.aws_ami.ubuntu_24_04.name
    description = "Name of Ubuntu AMI"
}