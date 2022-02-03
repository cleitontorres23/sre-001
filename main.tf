#############################################################################
##                Environment Deploy with Terraform                        ##
##      - VPC                                                              ##
##      - subnet                                                           ##
##      - load balancer                                                    ##
##      - public and private ip                                            ##
##      - gateway                                                          ##
#############################################################################

# version control
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.0.0, <= 3.31.0"
    }
  }
}

# Creating a provider AWS as default
provider "aws" {
  region  = var.aws_region
}

# Creating a new instance of the latest Ubuntu 14.04 on an
resource "aws_instance" "webserver" {
  ami           = lookup(var.ami_web, var.aws_region)
  instance_type = "t2.micro"
  count         = var.aws_count_instante
  
  tags = {

    Name = "webserver-${count.index + 1}"
  }
}
