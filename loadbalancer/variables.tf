variable "lb_name" {
    type = string
  
}
variable "la_internal" {
    type = string
  
}
variable "lb_type" {
    type = string
  
}
variable "lb_seg" {

  
}
variable "lb_subnets" {
    type = list(string)
  
}
variable "tg_name" {
    type = string
  
}
variable "vpc_id" {
    type = string
  
}
variable "ec2_instance_id" {
    type = string
  
}
variable "lb_listener_port" {
    type = string
  
}
variable "lb_listener_protocal" {
  
}
variable "lb_listner_default_action" {
  
}
variable "lb_https_listner_protocol" {
  
}
variable "lb_https_listner_port" {
  
}
variable "dev_acm_arn" {
  
}