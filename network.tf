# The VPC Virtual Private Cloud 
resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_main"
  }
}

#Create internet gateway
resource "aws_internet_gateway" "gateway_external" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "gateway_external"
  }
}

# Creating a subnet and make association with vpc_main and availability zones
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc_main.id
  count      = length(var.subnet_cidr) //get the number of ip blocks in this case, 2
  cidr_block = var.subnet_cidr[count.index] //get the ip block in variable file

  map_public_ip_on_launch = "true"

  #depends_on = [aws_internet_gateway.gateway_external]

  tags = {
    Name = "subnet-${count.index}"
  }
}