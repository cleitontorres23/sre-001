# Output variable definitions
output "ec2_instance_private_ips" {
  description = "Private IP addresses of EC2 instances"
  value = aws_instance.webserver.*.private_ip
 }