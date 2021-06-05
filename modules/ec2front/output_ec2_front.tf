output "jmp_hst_public_ips" {
  description = "List of public IP addresses assigned to instances"
  value       = aws_instance.jmp_hst[*].public_ip
}

output "jmp_hst_private_ips" {
  description = "List of private IP addresses assigned to instances"
  value       = aws_instance.jmp_hst[*].private_ip
}

output "jmp_hst_ami" {
  description = "Contol instance ami"
  value       = aws_instance.jmp_hst[*].ami
}

output "instance_type" {
  description = "jmp_hst instance type"
  value       = aws_instance.jmp_hst[*].instance_type
}

output "jmp_hst_tags" {
  description = "jmp_hst instances tags"
  value       = aws_instance.jmp_hst[*].tags.Name
}

output "jmp_hst_instance_id" {
  description = "jmp_hst instance id output"
  value       = aws_instance.jmp_hst[*].id
}

output "jmp_hst_count" {
  description = "number of instances"
  value       = length(aws_instance.jmp_hst)
}

