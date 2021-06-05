provider "aws" {
  region = "eu-central-1"
}

# Module builds VPC network layer.
# Resources: 1xVPC, 1xPublic subnet, 2xPriv subnets, 2x NACL(front,back), 
#            3xRoute tables + 3xRoute table associations, Internet gateway, NAT gateway.

module "vpc_rt_igw" {

  source = "./modules/vpc_rt_igw"

}

# Module builds ec2 backend instances for private subnets
# EC2 instances: vm_dev0, vm_dev1

module "ec2back" {

  source = "./modules/ec2back"

  vpc_security_group_ids = module.secgroup.vm_dev_sg_ids[*]

  subnet_id = module.vpc_rt_igw.aws_subnet_ids[*]

}

# Module builds ec2 frontend jump host. 

module "ec2front" {

  source = "./modules/ec2front"

  sec_group = module.secgroup.jump_sg_id

  subnet_id = module.vpc_rt_igw.aws_subnet_pub

  control_count = "1"             # default value in variables file = 1
}

# Module builds security group for jump host and separate security groups for vm_dev0 and vm_dev1. 

module "secgroup" {

  source = "./modules/secgroup"

  vpc_id = module.vpc_rt_igw.vpc_id
}

# Module create ansible hosts file and writes instances ip's into.

module "localfiles" {

  source = "./modules/localfiles"

  vm_dev_name     = module.ec2back.vm_dev0dev1_tags
  vm_dev_ip       = module.ec2back.vm_dev0dev1_public_ip
  vm_dev_priv_ip  = module.ec2back.vm_dev0dev1_private_ip
  jmp_hst_priv_ip = module.ec2front.jmp_hst_private_ips
  jmp_hst_name    = module.ec2front.jmp_hst_tags
  jmp_hst_ip      = module.ec2front.jmp_hst_public_ips

}


