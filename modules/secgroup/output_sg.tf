
output "jump_sg_id" {
  description = "security group id jump_sg"
  value       = aws_security_group.jump_sg.id
}

output "jump_sg_name" {
  description = "security group name jump_sg"
  value       = aws_security_group.jump_sg.name
}

output "vm_dev0_sg_id" {
  description = "security group id vm_dev0_sg"
  value       = aws_security_group.vm_dev0_sg.id
}

output "vm_dev0_sg_name" {
  description = "security group name vm_dev0_sg"
  value       = aws_security_group.vm_dev0_sg.name
}

output "vm_dev1_sg_id" {
  description = "security group id vm_dev1_sg"
  value       = aws_security_group.vm_dev1_sg.id
}

output "vm_dev1_sg_name" {
  description = "security group name vm_dev1_sg"
  value       = aws_security_group.vm_dev1_sg.name
}

output "vm_dev_sg_ids" {
  description = "vm_dev_0 & vm_dev_1 security groups ids"
  value       = [aws_security_group.vm_dev0_sg.id, aws_security_group.vm_dev1_sg.id]
}
