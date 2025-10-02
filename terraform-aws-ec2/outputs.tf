output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.ec2.id
}

output "k8s_control_hostname" {
  description = "Hostname público da instância de controle"
  value       = aws_instance.k8s_control.public_dns
}

output "public_ip" {
  description = "IP público da instância master"
  value       = aws_instance.ec2.public_ip
}

output "public_dns" {
  description = "DNS público da instância"
  value       = aws_instance.ec2.public_dns
}
