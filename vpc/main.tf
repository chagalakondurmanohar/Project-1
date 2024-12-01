resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cider
    tags = {
      name = var.vpc_name
    }
    
}
 resource "aws_subnet" "vpc_public_subnet" {
    count= length(var.vpc_public_subnet)
    vpc_id = aws_vpc.vpc.id
    cidr_block = element(var.vpc_public_subnet,count.index)
    availability_zone = element(var.pulic_subnet_availability_zone, count.index)
 }

 resource "aws_subnet" "vpc_private_subnet" {
    count= length(var.vpc_private_subnet)
    vpc_id = aws_vpc.vpc.id
    cidr_block = element(var.vpc_private_subnet,count.index)
    availability_zone = element(var.private_subnet_availability_zone, count.index)
 }

 resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc
    tags = {
       Name = "dev-proj-1-igw"
    }
   
 }
 resource "aws_route_table" "route_table" {
   vpc_id = aws_vpc.vpc.id
   route = {
    cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
   }
     tags = {
    Name = "public-rt"
  }
 }

 resource "aws_route_table_association" "route_assosiation" {
    count = length(aws_subnet.vpc_public_subnet)
   subnet_id = aws_subnet.vpc_public_subnet[count.index].id
    route_table_id = aws_route_table.route_table.id
   
 }

  resource "aws_route_table" "private_route_table" {
   vpc_id = aws_vpc.vpc.id
   route = {
    cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
   }
     tags = {
    Name = "private-rt"
  }
 }

 resource "aws_route_table_association" "private_route_assosiation" {
    count = length(aws_subnet.vpc_private_subnet)
   subnet_id = aws_subnet.vpc_private_subnet[count.index].id
    route_table_id = aws_route_table.route_table.id
   
 }