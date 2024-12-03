output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.vpc_public_subnet.*.cidr_block
}

output "vpc_public_subnet_id" {
    value = aws_subnet.vpc_public_subnet.*.id
  
}