# The VPC Virtual Private Cloud 
resource "aws_vpc" "vpc_main" {
  count = var.aws_count_instante
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  #az             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  #public_subnets =  element(var.subnet_cidr, count.index)
  #primary_network_interface_id  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  #enable_nat_gateway = true
  #enable_vpn_gateway = true

  tags = {
    Name = "vpc_main"
  }
}

data "aws_availability_zones" "az" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.az.names
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    project     = "project-alpha",
    environment = "dev"
  }
}

#resource "aws_ec2_availability_zone_group" "az" {
#  group_name    = "us-west-2-lax-1"
#  opt_in_status = "opted-in"
#}
#
##Create internet gateway
#resource "aws_internet_gateway" "gateway_external" {
#  vpc_id = aws_vpc.vpc_main.id
#
#  tags = {
#    Name = "gateway_external"
#  }
#}
#
## Creating a subnet and make association with vpc_main and availability zones
#resource "aws_subnet" "subnet" {
#  vpc_id     = aws_vpc.vpc_main.id
#  count      = length(var.subnet_cidr) //get the number of ip blocks in this case, 2
#  cidr_block = var.subnet_cidr[count.index] //get the ip block in variable file
#
#  map_public_ip_on_launch = "true"
#
#  #depends_on = [aws_internet_gateway.gateway_external]
#
#  tags = {
#    Name = "subnet-${count.index}"
#  }
#}
#
#resource "aws_vpc_endpoint_route_table_association" "route_table" {
#  route_table_id  = aws_route_table.vpc_main.id
#  vpc_endpoint_id = aws_vpc_endpoint.route_table.id
#}