output "public_ip" {
  description = "IP público da instância"
  value       = aws_instance.ec2.public_ip
}

output "public_dns" {
  description = "DNS público da instância"
  value       = aws_instance.ec2.public_dns
}
