terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

module "vpc" {
    source = "./vpc"
  vpc_cider = var.vpc_cider
   vpc_name             = var.vpc_name
  vpc_public_subnet   = var.cidr_public_subnet
  pulic_subnet_availability_zone = var.eu_availability_zone
  vpc_private_subnet  = var.cidr_private_subnet
  private_subnet_availability_zone = var.private_subnet_availability_zone

}

module "seg" {
    source = "./seg"
    ec2_sg_name =var.ec2_sg_name
    vpc_id = module.vpc.vpc_id
    public_subnet_cidr_block = var.public_subnet_cidr_block
    ec2_sg_name_for_python_api = ec2_sg_name_for_python_api
  
}

module "ec2" {
    source = "./ec2"
    ami_id = var.ami_id

  instance_type = var.instance_type
  public_key = var.public_key
  enable_public_ip_address = var.enable_public_ip_address
  subnet_id = var.subnet_id
  user_data =""


}

module "lb" {
    source = "./loadbalancer"
  vpc_id = module.vpc.vpc_id
  lb_listener_port var.lb_listener_port
}