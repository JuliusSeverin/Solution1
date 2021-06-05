# vpc creation
resource "aws_vpc" "vpc_task1" {

  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# Public subnet for jump host instance and NAT
resource "aws_subnet" "sub_dms_0" {

  vpc_id                  = aws_vpc.vpc_task1.id
  cidr_block              = var.sub_dms_0_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az_1

  tags = {
    Name = "sub_dms_0"
  }
}

# Private subnet for vm_dev0 instance
resource "aws_subnet" "sub_priv_0" {

  vpc_id                  = aws_vpc.vpc_task1.id
  cidr_block              = var.sub_priv_0_cidr
  map_public_ip_on_launch = false
  availability_zone       = var.az_2

  tags = {
    Name = "sub_priv_0"
  }
}

# Private subnet for vm_dev1 instance
resource "aws_subnet" "sub_priv_1" {

  vpc_id                  = aws_vpc.vpc_task1.id
  cidr_block              = var.sub_priv_1_cidr
  map_public_ip_on_launch = false
  availability_zone       = var.az_3

  tags = {
    Name = "sub_priv_1"
  }
}

# Internet gateway
resource "aws_internet_gateway" "igw_vpc_task1" {

  vpc_id = aws_vpc.vpc_task1.id

  tags = {
    Name = "igw-vpc_task1"
  }
}

# Elastic IP for Nat Gateway
resource "aws_eip" "eip_nat_vpc_task1" {

  depends_on = [aws_internet_gateway.igw_vpc_task1]
}

# Nat Gateway to provide internet access for vm_dev0
resource "aws_nat_gateway" "nat_vpc_task1" {

  allocation_id = aws_eip.eip_nat_vpc_task1.id

  subnet_id = aws_subnet.sub_dms_0.id

  tags = {
    Name = "nat_vpc_task1"
  }
}

# Route table for public subnet (jump_host). Route pointing igw.
resource "aws_route_table" "rt_pub_dms0" {

  vpc_id = aws_vpc.vpc_task1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc_task1.id
  }

  tags = {
    Name = "rt_pub_dms0"
  }
}

# Route table association with public subnet
resource "aws_route_table_association" "rt_pub_dms0_assoc" {

  subnet_id      = aws_subnet.sub_dms_0.id
  route_table_id = aws_route_table.rt_pub_dms0.id

}

# Route table for private subnet 0 (vm_dev0). Route pointing nat.
resource "aws_route_table" "rt_priv0" {

  vpc_id = aws_vpc.vpc_task1.id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_vpc_task1.id
  }

  tags = {
    Name = "rt_priv0"
  }
}

# Route table association with private subnet 0
resource "aws_route_table_association" "rt_priv0_assoc" {

  subnet_id      = aws_subnet.sub_priv_0.id
  route_table_id = aws_route_table.rt_priv0.id

}

# Route table for private subnet 1 (vm_dev1). Only local communication. Internet access forbiden due to project requirements.
resource "aws_route_table" "rt_priv1" {

  vpc_id = aws_vpc.vpc_task1.id

  tags = {
    Name = "rt_priv1"
  }
}

#Route table association with private subnet 1
resource "aws_route_table_association" "rt_priv1_assoc" {

  subnet_id      = aws_subnet.sub_priv_1.id
  route_table_id = aws_route_table.rt_priv1.id

}

# Network Acces Contol List and rules for frontend public subnet (jump host, nat).
resource "aws_network_acl" "front" {

  vpc_id     = aws_vpc.vpc_task1.id
  subnet_ids = [aws_subnet.sub_dms_0.id]
  
  
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  # icmp set to all -1 -1.
  ingress {
    protocol   = "icmp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    icmp_type  = -1
    icmp_code  = -1
  }
  # ephemeral ports rule for ssh response from vm_dev0.
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  
  egress {
    protocol   = "icmp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    icmp_type  = -1
    icmp_code  = -1
  }
  
  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  
  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  tags = {
    Name = "acl_front"
  }
}

# Network Acces Contol List and rules for backend private subnets (sub_priv0, sub_priv1).
# Rules are same as for front acl
resource "aws_network_acl" "back" {

  vpc_id     = aws_vpc.vpc_task1.id
  subnet_ids = [aws_subnet.sub_priv_0.id, aws_subnet.sub_priv_1.id]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "icmp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    icmp_type  = -1
    icmp_code  = -1
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "icmp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    icmp_type  = -1
    icmp_code  = -1
  }
  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "acl_back"
  }
}