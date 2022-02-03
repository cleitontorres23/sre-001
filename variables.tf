# Variable files
variable "aws_region"{
  description   = "Default region to set"  
  default       = "us-east-1" 
}

# Variable to get Ubuntu Image free tier
variable "ami_web" {
    description = "Image id to deploy EC2"
    type = map
    default = {
        "us-east-1" = "ami-0ac80df6eff0e70b5"
  }
}

# How many instances is going up
variable "aws_count_instante"{
    description = " Number of EC2 deliveried"
    default = 3
}

# List the subnets have requested network 
variable "subnet_cidr"{
  default = ["10.10.100.0/24","10.10.200.0/24"]
}