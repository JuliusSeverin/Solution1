variable "cidr_block" {

  default = "10.0.0.0/16"
}

variable "vpc_name" {

  default = "vpc_task1"
}

variable "sub_dms_0_cidr" {

  default = "10.0.0.0/24"
}

variable "sub_priv_0_cidr" {

  default = "10.0.1.0/24"
}

variable "sub_priv_1_cidr" {

  default = "10.0.2.0/24"
}

variable "subnets_all" {

  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "az_1" {

  default = "eu-central-1a"
}

variable "az_2" {

  default = "eu-central-1b"
}

variable "az_3" {

  default = "eu-central-1c"
}

variable "az_all" {

  default = ["eu-central-1a", "eu-central-1b", "eu-central-3c"]
}
