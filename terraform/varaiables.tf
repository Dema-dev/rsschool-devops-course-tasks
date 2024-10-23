variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["192.168.10.0/24", "192.168.11.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "PrivateRoute" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["Private Route A", "Private Route B"]
}

variable "aws_key_name" {
  default = "aws"
}

variable "k3s_master_instance_type" {
  description = "instance type for k8s node"
  default = "t3.small"
}

variable "k8s_master_node_disk" {
  description = "disk type for k8s node"
  default = {
    size = 30
    type = "gp3"
  }
}

variable "k3s_worker_node_count" {
  description = "Number of kuber workers nodes to create"
  default     = 1
}

variable "k8s_worker_node_type" {
  description = "instance type for k8s node"
  default     = "t3a.small"
}

variable "k8s_worker_node_disk" {
  description = "disk type for k8s node"
  default = {
    size = 50
    type = "gp3"
  }
}

variable "k8s_worker_node_tenancy" {
  description = "provision tenancy for k8s node"
  default     = "default"
}

variable "path_sh" {
  default = "./sh"
  
}

