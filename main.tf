terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

module "vpc" {
  source                           = "./vpc"
  vpc_cider                        = var.vpc_cider
  vpc_name                         = var.vpc_name
  vpc_public_subnet                = var.cidr_public_subnet
  pulic_subnet_availability_zone   = var.pulic_subnet_availability_zone
  vpc_private_subnet               = var.cidr_private_subnet
  #private_subnet_availability_zone = var.private_subnet_availability_zone

}

module "seg" {
  source                     = "./seg"
  ec2_sg_name                = var.ec2_sg_name
  vpc_id                     = module.vpc.vpc_id
  public_subnet_cidr_block   = tolist(module.vpc.public_subnet_cidr_block)
  ec2_sg_name_for_python_api = "ec2_sg_name_for_python_api"

}

module "ec2" {
  source = "./ec2"
  ami_id = var.ami_id

  instance_type            = var.instance_type
  public_key               = var.public_key
  enable_public_ip_address = "true"
  subnet_id                = tolist(module.vpc.vpc_public_subnet_id)[0]
  user_data                = templatefile("./userdsts.sh", {})
  lb_seg = module.seg.lb_seg
sg_ec2_for_python_api  = module.seg.sg_ec2_for_python_api


}

module "lb" {
  source                    = "./loadbalancer"
  lb_name                   = var.lb_name
  vpc_id                    = module.vpc.vpc_id
  lb_listener_port          = 5000
  ec2_instance_id           = module.ec2.ec2_instance_id
  lb_subnets                = tolist(module.vpc.vpc_public_subnet_id)
  lb_listner_default_action = "forword"
  lb_type                   = "application"
  tg_name                   = "elbtg"
  la_internal               = "false"
  lb_https_listner_protocol = "HTTP"
  dev_acm_arn               = module.cerification.dev_acm_arn
  lb_https_listner_port     = "443"
  lb_seg                    = module.seg.lb_seg
  lb_listener_protocal      = "HTTPS"


}

module "hosted_zone" {
  source          = "./hosted_zone"
  domain_name     = "devopschr.in"
  aws_lb_dns_name = module.lb.aws_lb_dns_name
  aws_lb_zone_id  = module.lb.aws_lb_zone_id
}

module "rds" {
  source               = "./rds"
  db_subnet_group_name = "dev_rgds"
  subnet_groups        = tolist(module.vpc.vpc_public_subnet_id)
  rds_mysql_sg_id      = module.seg.rds_mysql_sg_id
  mysql_db_identifier  = "mydb"
  mysql_dbname         = "user"
  mysql_password       = "main"
  mysql_username       = "user"
}
module "cerification"{
  source = "./cerificate_manager"
  hosted_zone_id = module.lb.aws_lb_zone_id
  domain_name ="chrdevops.in"

}