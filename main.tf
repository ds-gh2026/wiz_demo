##########################################
# Default VPC
# Using Default VPC created in AWS

data "aws_vpc" "default" {
  default = true
}

##########################################
# Default Subnet
# Using Default Subnet created in AWS

data "aws_subnets" "default" {
  filter {
    name    = "vpc-id"
    values  = [data.aws_vpc.default.id]
  }
}

##########################################
# SECURITY RISK: RDP open
# Serucity Risk for Demo
# Wiz will detect
# Allowing RDP (Remote Access) from anywhere from internet
##########################################
resource "aws_security_group" "oepn_rdp" {
  name        = "open-rdp-demo"
  description = "Demo SG with open RDP"
  vpc_id      = "data.aws_vpc.default.id"

  # INBOUND RULE
  # Anyone can connect to RDP through internet
  ingress {
    description  = "RDP open"
    from_port    = 3389
    to_port      = 3389
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  # OUTBOUND RULE
  egress {
    from _port  = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


##########################################
# Latest Windows Server AMI
# Terraform asks AWS for the latest Windows Server Image
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name    = "name"
    values  = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

# Windows EC2 (public)
resource "aws_instance" "demo_windows_ec2" {
    ami                         = data.aws_ami.windows.id
    instance_type               = "t3.micro"
    subnet_id                   = data.aws_subnets.default.ids[0]
    vpc_security_group_ids      = [aws_security_group.open_rdp.id]
    associate_public_ip_address = true
}

  tags = {
      Name = "Wiz-Terraform_Demo"
  }
}

resource "aws_network_interface_sg_attachment" "attach_demo_sg" {
  security_group_id      = aws_security_group.terraform_demo_sg.id
  network_interface_id   = "eni-02e19fe5474a747d2"
}
