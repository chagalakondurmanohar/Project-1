variable "ami_id" {
    type = string
  
}
variable "instance_type" {
    type = string
  
}

variable "subnet_id" {
    type = string
  
}
variable "enable_public_ip_address" {
    type =  bool
  
}

variable "user_data" {
    type = string
  
}

variable "public_key" {
    type = string
  
}