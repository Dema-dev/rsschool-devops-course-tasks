resource "aws_instance" "k3s_worker_nodes" {
    count = var.k3s_worker_node_count
    ami = data.aws_ami.ubuntu_24_04.id
    ebs_optimized = true
    subnet_id = aws_subnet.private_subnets[0].id
    instance_type = var.k8s_worker_node_type
    key_name = var.aws_key_name

    user_data = templatefile("${var.path_sh}/worker_node.sh.tpl",{
      hostname = "worker-node-${count.index+1}"

    })

    
    root_block_device {
      volume_size = var.k8s_worker_node_disk.size
      volume_type = var.k8s_worker_node_disk.type
      delete_on_termination = true
    }

    vpc_security_group_ids = [aws_security_group.Private-host.id]
    tags = {
        Name = "Worker Node ${count.index+1}"     
    }
  
}