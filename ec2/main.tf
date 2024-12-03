resource "aws_instance" "my_ec2" {
    ami = var.ami_id
    instance_type =  var.instance_type
    key_name = ""
    subnet_id =  var.subnet_id
    vpc_security_group_ids = [var.sg_ec2_for_python_api,var.lb_seg]
    associate_public_ip_address = var.enable_public_ip_address
   user_data = var.user_data
   metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

resource "aws_key_pair" "dev_proj_1_public_key" {
  key_name   = "batch9_key"
  public_key = var.public_key
}
