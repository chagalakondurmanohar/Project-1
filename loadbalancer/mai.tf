resource "aws_lb" "dev_lb" {
    name =   var.lb_name
    internal =   var.la_internal
    load_balancer_type = var.lb_type 
    security_groups =  var.lb_seg
    subnets =  var.lb_subnets
    enable_deletion_protection = false

}

resource "aws_lb_target_group" "dev_target_group" {
    name= var.tg_name
     port        = 5000
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id  = var.vpc_id
    health_check {
    path = "/health"
    port = 5000
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"  # has to be HTTP 200 or fails
  }
}

resource "aws_lb_target_group_attachment" "dev_alb_tg" {
    target_group_arn = aws_lb_target_group.dev_target_group.arn
    target_id = var.ec2_instance_id
    port =  5000
  
}

resource "aws_lb_listener" "dev_lb_listener" {
    load_balancer_arn = aws_lb.dev_lb.arn
    port =  var.lb_listener_port
    protocol = var.lb_listener_protocal
  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

resource "aws_lb_listener" "dev_lb_https_listner" {
  load_balancer_arn = aws_lb.dev_proj_1_lb.arn
  port              = var.lb_https_listner_port
  protocol          = var.lb_https_listner_protocol
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.dev_acm_arn

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}