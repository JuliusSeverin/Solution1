
output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.vpc_task1.id
}

output "aws_subnet_pub" {
  description = "aws subnet sub_dms_0 id"
  value       = aws_subnet.sub_dms_0.id
}

output "aws_subnet_priv0" {
  description = "aws subnet sub_priv_0 id"
  value       = aws_subnet.sub_priv_0.id
}

output "aws_subnet_priv1" {
  description = "aws subnet sub_priv_1 id"
  value       = aws_subnet.sub_priv_1.id
}

output "aws_subnet_ids" {
  description = "aws subnets ids all"
  value       = [aws_subnet.sub_priv_0.id, aws_subnet.sub_priv_1.id]
}

output "aws_internet_gateway" {
  description = "aws internet gateway igw_vpc_task1 id"
  value       = aws_internet_gateway.igw_vpc_task1.id
}

output "aws_nat_gateway" {
  description = "aws nat gateway igw_vpc_task1 id"
  value       = aws_nat_gateway.nat_vpc_task1.id
}

output "aws_route_table_pub" {
  description = "aws route table rt_pub_dms0 id"
  value       = aws_route_table.rt_pub_dms0.id
}

output "aws_route_table_priv0" {
  description = "subnet2 aws route table rt_priv0 id"
  value       = aws_route_table.rt_priv0.id
}

output "aws_route_table_priv1" {
  description = "subnet2 aws route table rt_priv1 id"
  value       = aws_route_table.rt_priv0.id
}


