variable "region" {
    type        = string
    default     = "us-east-1"
    description = "Name of the Region"
}    
variable "vpc_name" {
    type        = string
    description = "Name of the VPC"
    default     = "VPC-1"
}
variable "instance_name" {
    type        = string
    description = "Name of the EC2 instance deployed."
    default     = "vm-test"
}
variable "ami" {
    type        = string
    description = "ami of instances to be deployed"
    default     = "ami-0f0c9a552f9ec134a"
}
variable "instance_type" {
    type        = string
    description = "Instance type"
    default     = "t2.micro"
}
variable "application" {
    type        = string
    description = "Name of the application"
    default     = "aws_ec2_linux_instance"
}

variable "service" {
    type        = string
    description = "Name of the service"
    default     = "Infrastructure layer"
}

variable "owner" {
    type        = string
    description = "Name of the owner"
    default     = "infra@insight.com"
}

variable "environment" {
    type        = string
    description = "Name of the environment"
    default     = "test"
}

output "aws_ec2_linux" {
    value       = "application"
    description = "application"
}
     