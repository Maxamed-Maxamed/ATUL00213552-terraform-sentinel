# DEMO ONLY. This file exists only on the demo/non-compliant branch.
# It proves that Sentinel rejects a non-compliant plan in HCP Terraform.
# This branch must never be merged or applied.

# Breaks sovereignty: the volume is outside Ireland and is tagged
# sensitive without a DataResidency tag.
# Breaks encryption: the volume is not encrypted.
resource "aws_ebs_volume" "outside_ireland" {
  region            = "us-east-1"
  availability_zone = "us-east-1a"
  size              = 8
  encrypted         = false

  tags = {
    Name           = "demo-non-compliant-volume"
    Classification = "sensitive"
  }
}

# Breaks ec2: the instance type is not approved and IMDSv1 is allowed.
# Breaks encryption: the root volume is not encrypted.
# The type is hardcoded, so the variable validation never sees it.
resource "aws_instance" "non_compliant" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "m5.large"
  subnet_id     = aws_subnet.public.id

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  root_block_device {
    encrypted = false
  }
}

# Breaks network: SSH is open to the whole internet.
resource "aws_vpc_security_group_ingress_rule" "ssh_from_anywhere" {
  security_group_id = aws_security_group.instance.id
  description       = "Demo only: unrestricted SSH"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}