#by Ali Akturin for CS312 System Administration Project 2

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "app_server" {
  ami                    = "ami-01cd4de4363ab6ee8"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = aws_key_pair.kp.key_name
  tags = {
    Name = "MC_Server_Auto"
  }
}

resource "aws_eip" "mc_ip" {
  vpc      = true
  instance = aws_instance.app_server.id
  tags = {
    Name = "MC_Server_ip_for_pj2"
  }
}


