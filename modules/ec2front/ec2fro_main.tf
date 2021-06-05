# aws ec2 instance jump host
resource "aws_instance" "jmp_hst" {

  subnet_id              = var.subnet_id
  count                  = var.control_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.klucze
  vpc_security_group_ids = [var.sec_group]

  ebs_block_device {

    volume_size           = "10"
    volume_type           = "gp2"
    device_name           = "/dev/sda1"        # for details see "aws block device mappings" https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html
    delete_on_termination = true
  }

  tags = {
    Name = "Jump_Host"
  }
}