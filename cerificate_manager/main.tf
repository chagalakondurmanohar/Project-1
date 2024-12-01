resource "aws_acm_certificate" "dev_acm_arn" {
    domain_name  = var.domain_name
   tags = {
    Environment = "dev"
  }
    lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
for dev in aws_acm_certificate.dev_acm_arn.domain_validation_options : dev.domain_name =>{
      name   = dev.resource_record_name
      record = dev.resource_record_value
      type   = dev.resource_record_type
}
  }
  zone_id = var.hosted_zone_id # replace with your Hosted Zone ID
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}