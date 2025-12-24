resource "aws_security_group" "terraform_demo_sg" {
  name        = "terraform-demo-sg"
  description = "Terraform-managed demo SG"
  vpc_id      = "vpc-033116979fdff77e7"

  ingress {
    description  = "Demo SSH open"
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags = {
    ManagedBy = "Terraform"
    Demo      = "Wiz"
  }
}
