# aws ec2 backend instance vm_dev0
resource "aws_instance" "vm_dev0" {

  subnet_id = var.subnet_id[0]                               # subnet id passed from vpc_igw_rt module 
  #count                  = var.control_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.klucze
  vpc_security_group_ids = [var.vpc_security_group_ids[0]]   # sec group id passed from secgroup module

  ebs_block_device {

    volume_size           = "10"
    volume_type           = "gp2"
    device_name           = "/dev/sda1" # for details see "aws block device mappings" https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html
    delete_on_termination = true
  }

  tags = {
    Name = "VM_Dev0"
  }
}

# aws ec2 backend instance vm_dev1
resource "aws_instance" "vm_dev1" {

  subnet_id = var.subnet_id[1]                                # subnet id passed from vpc_igw_rt module
  #count                  = var.control_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.klucze
  vpc_security_group_ids = [var.vpc_security_group_ids[1]]    # sec group id passed from secgroup module

  ebs_block_device {

    volume_size           = "10"
    volume_type           = "gp2"
    device_name           = "/dev/sda1" # for details see "aws block device mappings" https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html
    delete_on_termination = true
  }

  tags = {
    Name = "VM_Dev1"
  }
}

