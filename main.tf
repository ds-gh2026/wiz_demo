# 1. Identifies existing EC2 Instance
# 2. Uses its attached Security Group
# 3. Adds inbound rule: RDP (3389) allowing connection from anywhere
# 4. Wiz Detecs exposure

##########################################
# Identify existing EC2 instance
variable "instance_id" {
  type        = string
  description = "Existing EC2 instance ID"
}

##########################################
# Read existing EC2 Instance
data "aws_instance" "existing" {
  instance_id = var.instance_id
}

##########################################
# Select Security Group attached to the EC2 Instance
locals {
  security_group_id = tolist(data.aws_instance.existing.vpc_security_group_ids[0])
}

##########################################
# Add an inbound rule allowing RDP from internet
resource "aws_security_group" "oepn_rdp" {
  type              = "ingress"
  security_group_id = "local.security_group_id"
  
  from_port    = 3389
  to_port      = 3389
  protocol     = "tcp"
  cidr_blocks  = ["0.0.0.0/0"]

  description  = "RDP open to the internet"
}