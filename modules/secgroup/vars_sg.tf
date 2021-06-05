variable "vpc_id" {

  default = {}
}

variable "dynamic_jump_sg" {
  description = "map inbound from 22 80"

  type = map(any)
  default = {
    "22" = ["0.0.0.0/0"]
    "80" = ["0.0.0.0/0"]


  }
}
