locals {
  tags = {
    Name          = "Linux ${var.instance_name}"
    application   = var.application
    service       = var.service
    owner         = var.owner
    environment   = var.environment
  }
}

module "ec2_linux_instance" {
  source                   ="./modules"
  region                   = var.region
  ami                      = var.ami
  instance_name            = var.instance_name
  instance_type            = var.instance_type
  vpc_name                 = var.vpc_name 
  tags                     = local.tags
}