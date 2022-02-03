#Creating security group to allow ssh access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_main.id
  
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["179.118.250.192/32"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
     cidr_blocks = ["179.118.250.192/32"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Associate Security Group for ssh to resource webservice
resource "aws_network_interface_sg_attachment" "sg_ssh" {
  count = var.aws_count_instante
  security_group_id         = aws_security_group.allow_ssh.id
  network_interface_id      = element(aws_instance.webserver.*.primary_network_interface_id, count.index)
  }