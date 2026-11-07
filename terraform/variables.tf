variable "aws_region" {
  description = "Approved AWS region for Irish data residency"
  type        = string
  default     = "eu-west-1"

  validation {
    condition     = var.aws_region == "eu-west-1"
    error_message = "The AWS region must be eu-west-1 for Irish data residency."
  }
}