##### PLACEHOLDER VPC
variable "vpc_id" {
  type    = string
  default = "vpc-00000000000000000000000"
}

##### DEFINING A SECURITY GROUP IN TERRAFORM
resource "aws_security_group" "insecure_rdp" {

  name        = "wiz-demo-insecure-rdp"
  description = "Insecure RDP open to internet"

  vpc_id      = var.vpc_id

  ###### INBOUND RULE
  ###### This is the security problem we want Wiz to detect
  ingress {
      
      ###### RDP port for Windows
      from_port = 3389
      to_port   = 3389

      ###### TCP Protocol
      protocol  = "tcp"

      ###### 0.0.0.0/0 "Open to internet"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ##### OUTBOUND RULE
  ##### Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}