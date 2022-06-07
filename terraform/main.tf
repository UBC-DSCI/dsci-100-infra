terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.17"
    }
    
    # A local provider
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region = "ca-central-1"
}

resource "random_pet" "server" {
}

resource "aws_instance" "jhub" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.egress.id,
    aws_security_group.allow_http_sg.id,
    aws_security_group.allow_https_sg.id,
    aws_security_group.allow_ssh_sg.id
  ]
  availability_zone = "ca-central-1a"
  tags = {
    Name = "${random_pet.server.id}"
  }
}

resource "aws_volume_attachment" "ebs_docker_att" {
  device_name = "/dev/sdg"
  volume_id = aws_ebs_volume.ebs_docker.id
  instance_id = aws_instance.jhub.id
}

resource "aws_volume_attachment" "ebs_zfs_att" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.ebs_zfs.id
  instance_id = aws_instance.jhub.id
}

resource "aws_ebs_volume" "ebs_docker" {
  availability_zone = var.availability_zone
  size = var.docker_size
}

resource "aws_ebs_volume" "ebs_zfs" {
  availability_zone = var.availability_zone
  size = var.zfs_size
}

resource "aws_security_group" "allow_http_sg" {
  name        = "allow_http_sg"
  description = "Allow inbound inbound traffic"
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "allow_https_sg" {
  name        = "allow_https_sg"
  description = "Allow inbound inbound traffic"
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "allow_ssh_sg" {
  name        = "allow_ssh_sg"
  description = "Allow inbound inbound traffic"
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "egress" {
  name        = "egress"
  description = "Allow all outbound traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

