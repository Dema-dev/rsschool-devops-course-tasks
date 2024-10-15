### Project Structure:
``` bash
├── README.md
├── images
│   └── task_2
│      
└── terraform
│   ├── acl.tf
│   ├── create_ec2.tf
│   ├── iam_oidc_settings.tf
│   ├── network.tf
│   ├── providers.tf
│   ├── s3_tfstate_bucket.tf
│   ├── security_groups.tf
│   └── varaiables.tf
└── .github/
    └── workflows/
        └── ci_cd.yml
```
----------------------------------


### Terraform Code Implementation (50 points)
> All network configuration keeps here - [network.tf](terraform/network.tf)


Terraform code is created to configure the following:
- VPC
![alt text](images/task_2/vpc_created.png)

- 2 public subnets in different AZs
![alt text](images/task_2/public_subnets.png)

![alt text](images/task_2/var_public.png)

- 2 private subnets in different AZs
![alt text](images/task_2/private_subnets.png)

![alt text](images/task_2/var_private.png)


- Internet Gateway
![alt text](images/task_2/ig.png)

- Routing configuration:

Instances in all subnets can reach each other

![alt text](images/task_2/private_ping.png)

![alt text](images/task_2/public_host.png)

Instances in public subnets can reach addresses outside VPC and vice-versa

Bastion host in a public subnet 
![Bastion host](images/task_2/bastion_host_network.png)

He can reach addresses outside VPC and vise-versa and also all subnets in VPC

![alt text](images/task_2/ping_bastion.png)

![alt text](images/task_2/public_host.png)

---------------------------
### Code Organization (10 points)

- Variables are defined in a separate variables file.

All vars here - [varaiables.tf](terraform/varaiables.tf)

- Resources are separated into different files for better organization.

![alt text](images/task_2/recources_structure.png)

---------------

### Verification (10 points)

- Terraform plan is executed successfully.

> Check github actions - https://github.com/Dema-dev/rsschool-devops-course-tasks/actions

- A resource map screenshot is provided (VPC -> Your VPCs -> your_VPC_name -> Resource map).

![alt text](images/task_2/resource_map.png)

----------------------------------------

### Additional Tasks (30 points)

- Security Groups and Network ACLs (5 points)

Implement security groups and network ACLs for the VPC and subnets.

> Terraform file for Security groups - [security_groups.tf](terraform/security_groups.tf)

> Terraform file for ACLs - [acl.tf](terraform/acl.tf)

- Bastion Host (5 points)
Create a bastion host for secure access to the private subnets.

> Bastion host terraform file - [create_ec2.tf](terraform/create_ec2.tf)

![alt text](images/task_2/bastion_host_network.png)

- NAT is implemented for private subnets (10 points)

> NAT settings here - [network.tf](terraform/network.tf)

![alt text](images/task_2/nat_settings.png)

Orginize NAT for private subnets with simpler or cheaper way

![alt text](images/task_2/NAT_A.png) ![alt text](images/task_2/NAT_B.png)

Instances in private subnets should be able to reach addresses outside VPC

![alt text](images/task_2/private_host_network.png)

![alt text](images/task_2/private_ping_out.png)

- Documentation (5 points)
Document the infrastructure setup and usage in a README file.

- Submission (5 points)
A GitHub Actions (GHA) pipeline is set up for the Terraform code.

