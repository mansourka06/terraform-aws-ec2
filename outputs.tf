### terraform-aws-ec2/output.tf

output "infra_name" {
  value = "my aws infrastructure cluster"
}

output "instance_name" {
  description = "id of the EC2 instance"
  value       = aws_instance.myec2.host_id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.myec2.public_ip
}

