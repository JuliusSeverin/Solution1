output "vm_dev0dev1_public_ip" {
  description = "List of public IP addresses assigned to instances"
  value       = [aws_instance.vm_dev0.public_ip, aws_instance.vm_dev1.public_ip]
}

output "vm_dev0dev1_private_ip" {
  description = "List of private IP addresses assigned to instances"
  value       = [aws_instance.vm_dev0.private_ip, aws_instance.vm_dev1.private_ip]
}
output "vm_dev0dev1_tags" {
  description = "jmp_hst instances tags"
  value       = [aws_instance.vm_dev0.tags.Name, aws_instance.vm_dev1.tags.Name]
}

output "vm_dev0_ami" {
  description = "Contol instance ami"
  value       = aws_instance.vm_dev0[*].ami
}

output "vm_dev0_instance_type" {
  description = "ec2back instance type"
  value       = aws_instance.vm_dev0[*].instance_type
}

output "vm_dev1_ami" {
  description = "Contol instance ami"
  value       = aws_instance.vm_dev0[*].ami
}

output "vm_dev1_instance_type" {
  description = "ec2back instance type"
  value       = aws_instance.vm_dev0[*].instance_type
}

output "ec2back_instance_id" {
  description = "ec2back instance id output"
  value       = [aws_instance.vm_dev0.id, aws_instance.vm_dev1.id]
}

output "ec2back_count" {
  description = "number of instances"
  value       = length(aws_instance.vm_dev0[*])
}

