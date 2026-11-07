variable "aws_region" {
  description = "Approved AWS region for Irish data residency"
  type        = string
  default     = "eu-west-1"

  validation {
    condition     = var.aws_region == "eu-west-1"
    error_message = "The AWS region must be eu-west-1 for Irish data residency."
  }
}

variable "instance_type" {
  description = "Approved EC2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition = contains(
      ["t3.micro", "t3.small"],
      var.instance_type
    )

    error_message = "The EC2 instance type must be t3.micro or t3.small."
  }
}