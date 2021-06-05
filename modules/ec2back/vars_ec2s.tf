variable "ami_id" {
  default = "ami-05f7491af5eef733a" # ubuntuserver20.04. eu-central-1 Frankfurt
}

variable "instance_type" {
  default = "t2.micro"
}
variable "subnet_id" {

  default = {}
}
variable "aws_region" {
  default = "eu-central-1"
}

variable "vpc_security_group_ids" {

  default = {}
}

variable "klucze" {

  default = "ansk8fra"   #place ec2 keys here
}
