resource "aws_security_group" "ubuntu_sg" {
  name        = "ubuntu_security_group"
  description = "Allow SSH, HTTP, and HTTPS"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "ubuntu-sg"
    Owner = var.owner_name
  }
}
