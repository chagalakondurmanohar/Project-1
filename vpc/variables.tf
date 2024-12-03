
variable "vpc_cider" {
  type = string
  default = ""
}
variable "vpc_public_subnet" {
    type = list(string)
  
}
variable "pulic_subnet_availability_zone" {
     type = list(string)
}
variable "vpc_private_subnet" {
    type = list(string)
  
}

variable "vpc_name" {
  type = string
}