output "master_instance_id" {
  description = "ID da instância master"
  value       = aws_instance.master.id
}

output "master_dns_hostname" {
  description = "Hostname público da instância master"
  value       = aws_instance.master.public_dns
}

output "master_public_ip" {
  description = "IP público da instância master"
  value       = aws_instance.master.public_ip
}

output "worker1_instance_id" {
  description = "ID da instância worker"
  value       = aws_instance.worker[0].id
}

output "worker1_dns_hostname" {
  description = "Hostname público da instância worker"
  value       = aws_instance.worker[0].public_dns
}

output "worker1_public_ip" {
  description = "IP público da instância worker"
  value       = aws_instance.worker[0].public_ip
}

output "worker2_instance_id" {
  description = "ID da instância worker"
  value       = aws_instance.worker[1].id
}

output "worker2_dns_hostname" {
  description = "Hostname público da instância worker"
  value       = aws_instance.worker[1].public_dns
}

output "worker2_public_ip" {
  description = "IP público da instância worker"
  value       = aws_instance.worker[1].public_ip
}