# Secure VPC Architecture on AWS
This project creates a basic AWS VPC setup using **Terraform**.
The goal is to keep the web application servers in private subnets while allowing users to access the application through a public **Application Load Balancer**.

## What is created
* 1 VPC
* 2 public subnets
* 2 private subnets
* Internet Gateway
* 2 NAT Gateways
* Public and private route tables
* Security Groups and Network ACLs
* Bastion EC2 instance
* Application Load Balancer
* Auto Scaling Group for the web servers
The resources are spread across two Availability Zones for better availability.
## Basic Architecture
Internet
   |
   v
Load Balancer
   |
   v
Private Web Servers
   |
   v
NAT Gateway
   |
   v
Internet Gateway
The bastion host is used when we need to access a private EC2 instance.

## Requirements
* AWS account
* Terraform 1.5+
* AWS CLI configured
* EC2 key pair
* Your public IP address

## Setup
Go to the Terraform folder:
cd terraform

Create the variables file:
cp terraform.tfvars.example terraform.tfvars

Update the required values, especially:
key_pair_name
bastion_allowed_cidr

Then run:
terraform init
terraform plan
terraform apply

After deployment, Terraform will show the ALB DNS name and bastion public IP.
## Connecting to a Private Instance
First connect to the bastion:
ssh -A ec2-user@<bastion_public_ip>

Then connect to the private server:
ssh ec2-user@<private_instance_ip>

## Removing Everything
When finished:
terraform destroy


## Project Structure
├── README.md
├── docs/
│   └── architecture.md
├── scripts/
│   └── user_data.sh
└── terraform/
    ├── versions.tf
    ├── variables.tf
    ├── vpc.tf
    ├── subnets.tf
    ├── nacls.tf
    ├── security_groups.tf
    ├── bastion.tf
    ├── webapp.tf
    ├── outputs.tf
    └── terraform.tfvars.example

## Security Note
SSH access to the bastion should only be allowed from your own IP address. Avoid opening SSH to `0.0.0.0/0`.
This project is mainly for learning and demonstrating basic AWS networking and Terraform deployment.

done by HARSHA K
2/08/2026