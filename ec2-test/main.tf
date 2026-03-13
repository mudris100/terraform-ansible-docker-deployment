resource "aws_instance" "my_ubuntu" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.ssh_key
  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

output "ubuntu_public_ip" {
  value = aws_instance.my_ubuntu.public_ip
}
