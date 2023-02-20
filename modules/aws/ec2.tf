
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

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm_instance_profile"
  role = aws_iam_role.ssm_role.id
}

resource "aws_iam_role" "ssm_role" {
  name               = "ssm_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_role.name
}


resource "aws_instance" "bastion" {
  ami             = data.aws_ami.ubuntu20.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.main.key_name
  associate_public_ip_address = true
  subnet_id       = element(module.vpc.public_subnets, 1)
  security_groups = [module.sg-mgmt.security_group_id]
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  lifecycle {
      ignore_changes = [
        security_groups
      ]
  }

  tags = {
    owner = var.owner
    TTL   = var.ttl
    Name  = "VaultAgent"
  }
}


