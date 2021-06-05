# public subnet security group - jump host"

resource "aws_security_group" "jump_sg" {

  name        = "jump_sg"
  description = "Allow inbound from 22 80 ICMP"

  vpc_id = var.vpc_id

  # Allow inbound from 22 80. Port 80 rule left intentionally, blocked on acl level.
  dynamic "ingress" {
    for_each = var.dynamic_jump_sg
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      cidr_blocks = ingress.value
      protocol    = "tcp"
    }
  }
    
   
   # For all sec groups icmp set to all -1 -1. If need, value for echo reply: 8 0
   # from_port = icmp_type, to_port = icmp_code
   # more on this -->  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group 
  ingress {
    description = "ICMP ping"
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  # Allow all outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "jump_sg"
  }
}

# private subnet security group for ec2 vm_dev0. Ingres ssh rule points to jump host sec group
resource "aws_security_group" "vm_dev0_sg" {

  name        = "sub_priv0_sg"
  description = "Allow inbound from jump_sg 22, icmp"

  vpc_id = var.vpc_id
  
  # Ingres ssh rule points to jump host sec group
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump_sg.id]
  }
  ingress {
    description = "ICMP ping"
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vm_dev0_sg"
  }
}

# private subnet security group for ec2 vm_dev1. Ingres ssh rule points to jump host sec group
resource "aws_security_group" "vm_dev1_sg" {

  name        = "sub_priv1_sg"
  description = "Allow inbound from jump_sg 22, icmp"

  vpc_id = var.vpc_id

  # Ingres ssh rule points to jump host sec group
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump_sg.id]
  }
  ingress {
    description = "ICMP ping"
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vm_dev1_sg"
  }
}
