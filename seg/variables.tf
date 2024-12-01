variable "ec2_sg_name" {
    type = string
  
}

variable "vpc_id" {
    type = string
  
}
variable "public_subnet_cidr_block" {
    type = list(string)
  
}
variable "ec2_sg_name_for_python_api" {
    type = string
  
}