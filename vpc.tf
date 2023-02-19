resource "aws_vpc" "Lab_VPC" {
  cidr_block       = "172.0.0.0/16"
  instance_tenancy = "default"

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-Lab_VPC"
        Role: "${var.env_prefix}-Lab_VPC"
        Team: "team-${var.team}"
    
    }
}

resource "aws_subnet" "Lab_Subnet_1" {
  vpc_id     = aws_vpc.Lab_VPC.id
  cidr_block = "172.0.1.0/26"

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-Lab_VPC"
        Role: "${var.env_prefix}-Lab_VPC"
        Team: "team-${var.team}"
    
    }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.Lab_VPC.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "ssh"
    cidr_blocks      = [aws_vpc.Lab_VPC.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-ssh_SG"
        Role: "${var.env_prefix}-ssh_SG"
        Team: "team-${var.team}"
    
    }
}
