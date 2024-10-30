resource "aws_instance" "k3s_master_node" {
    ami = data.aws_ami.ubuntu_24_04.id
    ebs_optimized = true
    subnet_id = aws_subnet.public_subnets[0].id
    instance_type = var.k3s_master_instance_type
    key_name = var.aws_key_name
    private_ip = var.static_private_ip

    user_data = templatefile("${var.path_sh}/master_node.sh.tpl",{
      hostname = "master-node"
    })


    # user_data = file("${var.path_sh}/master_node.sh")
    
    root_block_device {
      volume_size = var.k8s_master_node_disk.size
      volume_type = var.k8s_master_node_disk.type
      delete_on_termination = true
    }

    vpc_security_group_ids = [aws_security_group.Bastion-host.id]
    tags = {
        Name = "Master Node"     
    }
  
}