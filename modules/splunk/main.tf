# Filter AMI to Centos
data "aws_ami" "centos" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

provider "aws" {
  region  = var.region
}

resource "aws_vpc" "splunk" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    name = "${var.prefix}-vpc-${var.region}"
    environment = "Production"
  }
}

resource "aws_subnet" "splunk" {
  vpc_id     = aws_vpc.splunk.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_security_group" "splunk" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.splunk.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 1514
    to_port     = 1514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8089
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9997
    to_port     = 9997
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-security-group"
  }
}

resource "aws_internet_gateway" "splunk" {
  vpc_id = aws_vpc.splunk.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "splunk" {
  vpc_id = aws_vpc.splunk.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.splunk.id
  }
}

resource "aws_route_table_association" "splunk" {
  subnet_id      = aws_subnet.splunk.id
  route_table_id = aws_route_table.splunk.id
}

resource "aws_eip" "splunk" {
  instance = aws_instance.splunk.id
  vpc      = true
}

resource "aws_eip_association" "splunk" {
  instance_id   = aws_instance.splunk.id
  allocation_id = aws_eip.splunk.id
}

resource "aws_instance" "splunk" {
  ami                         = data.aws_ami.centos.id
  instance_type               = var.instance_type 
  key_name                    = module.key_pair.key_pair_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.splunk.id
  vpc_security_group_ids      = [aws_security_group.splunk.id]

  root_block_device {
    volume_type = "gp2"
    volume_size = 100
  }

  tags = {
    Name = "${var.prefix}-splunk-instance"
    ttl  = var.ttl
    owner = var.name
  }

}

resource "null_resource" "configure-splunk-app" {
  depends_on = [aws_eip_association.splunk, local_sensitive_file.private_key_file ]

  provisioner "file" {
    source = "files/"
    destination = "/home/centos"
  }

  connection {
    type        = "ssh"
    user        = "centos"
    private_key = module.key_pair.private_key_pem
    host        = aws_eip.splunk.public_ip
  }


  provisioner "remote-exec" {
    inline = [
      "curl https://download.splunk.com/products/splunk/releases/8.2.5/linux/splunk-8.2.5-77015bc7a462-linux-2.6-x86_64.rpm -o /home/centos/splunk.rpm",
      "sudo chmod 644 /home/centos/splunk.rpm",
      "sudo rpm -i /home/centos/splunk.rpm",
      "sudo /opt/splunk/bin/splunk start --accept-license --no-prompt --answer-yes",
      "sudo /opt/splunk/bin/splunk enable boot-start",
      "sudo /opt/splunk/bin/splunk stop",
      "sudo cp /home/centos/user-seed.conf /opt/splunk/etc/system/local/user-seed.conf",
      "sudo mkdir -p /opt/splunk/etc/auth/mycerts",
      "sudo cp /home/centos/mySplunk* /opt/splunk/etc/auth/mycerts/",
      "sudo cp /home/centos/web.conf /opt/splunk/etc/system/local/",
      "sudo cp -f /home/centos/server.pem /opt/splunk/etc/auth/server.pem",
      "sudo /opt/splunk/bin/splunk start",
      /* "sudo /opt/splunk/bin/splunk install app /home/centos/hashicorp-cloud-platform-app-for-splunk_003.tgz -auth $(awk 'NR==2 {print $3}' /home/centos/user-seed.conf):$(awk 'NR==3 {print $3}' /home/centos/user-seed.conf)",
      "sudo /opt/splunk/bin/splunk install app /home/centos/hashicorp-vault-app-for-splunk_103.tgz -auth $(awk 'NR==2 {print $3}' /home/centos/user-seed.conf):$(awk 'NR==3 {print $3}' /home/centos/user-seed.conf)",
      "sudo /opt/splunk/bin/splunk install app /home/centos/terraform-cloud-for-splunk_008.tgz -auth $(awk 'NR==2 {print $3}' /home/centos/user-seed.conf):$(awk 'NR==3 {print $3}' /home/centos/user-seed.conf)", */
      "sudo sh /home/centos/hec_config.sh",
      "sudo sh /home/centos/enable_index.sh",
    ]

    connection {
      type        = "ssh"
      user        = "centos"
      private_key = module.key_pair.private_key_pem
      host        = aws_eip.splunk.public_ip
    }
  }
}