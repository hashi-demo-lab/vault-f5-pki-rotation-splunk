
data "aws_ami" "ubuntu20" {

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["099720109477"]
}

resource "aws_eip" "main" {
  instance = aws_instance.bastion.id
  vpc      = true
}

resource "aws_eip_association" "main" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.main.id
}


resource "aws_key_pair" "main" {
  key_name   = var.aws_key_pair_key_name
  public_key = var.ssh_pubkey
  
}




resource "aws_instance" "bastion" {
  ami             = data.aws_ami.ubuntu20.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.main.key_name
  associate_public_ip_address = true
  subnet_id       = element(module.vpc.public_subnets, 1)
  security_groups = [module.sg-mgmt.security_group_id]

  lifecycle {
    ignore_changes = all
  }

  tags = {
    owner = var.owner
    TTL   = var.ttl
  }
}
