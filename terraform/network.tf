# Virtual Private Cloud for the project
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "sovereignty-vpc"
    Environment = "assignment"
  }
}

# Public subnet in the Ireland region
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "sovereignty-public-subnet"
    Environment = "assignment"
  }
}

# Internet gateway connected to the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "sovereignty-internet-gateway"
  }
}

# Route table for the public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "sovereignty-public-route-table"
  }
}

# Connect the public subnet to the route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security group with no inbound access
resource "aws_security_group" "instance" {
  name        = "sovereignty-instance-security-group"
  description = "No unrestricted inbound access is permitted"
  vpc_id      = aws_vpc.main.id

  # Allow outbound HTTPS for approved software updates
  egress {
    description = "Allow outbound HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sovereignty-instance-security-group"
  }
}