provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project    = "Terraform Digital Sovereignty"
      StudentID  = "ATUL00213552"
      ManagedBy  = "Terraform"
      DataRegion = "Ireland"
    }
  }
}