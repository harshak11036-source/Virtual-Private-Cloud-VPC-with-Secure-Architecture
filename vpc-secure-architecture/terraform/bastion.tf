resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  metadata_options {
    http_tokens = "required" # enforce IMDSv2
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "${var.project_name}-bastion"
  }
}
