variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used for tagging all resources"
  type        = string
  default     = "secure-vpc-demo"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of Availability Zones to spread subnets across"
  type        = number
  default     = 2
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private (app) subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name used for SSH access to the bastion host"
  type        = string
}

variable "bastion_allowed_cidr" {
  description = "CIDR allowed to SSH into the bastion host (lock this down to your IP, e.g. 203.0.113.10/32)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for bastion and web app instances"
  type        = string
  default     = "t3.micro"
}

variable "web_app_desired_capacity" {
  description = "Number of web app instances in the private subnet"
  type        = number
  default     = 2
}
