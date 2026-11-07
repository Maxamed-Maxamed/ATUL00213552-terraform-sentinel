# Find the latest Amazon Linux 2023 AMI in the Ireland region
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Compliant EC2 instance
resource "aws_instance" "compliant" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.instance.id]

  # Prevent the instance from receiving a public IPv4 address
  associate_public_ip_address = false

  # Require Instance Metadata Service Version 2
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # Encrypt the root EBS volume
  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 8
  }

  tags = {
    Name           = "sovereignty-compliant-instance"
    Classification = "sensitive"
    DataResidency  = "Ireland"
  }
}
