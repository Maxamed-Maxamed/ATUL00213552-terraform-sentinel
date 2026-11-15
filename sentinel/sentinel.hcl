# Policy set for HCP Terraform.
# The Free edition allows one policy set with up to five policies,
# so the EC2 instance type and IMDSv2 checks share one policy file.

policy "sovereignty" {
  source            = "./sovereignty.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "supply_chain" {
  source            = "./supply_chain.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "ec2" {
  source            = "./ec2.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "encryption" {
  source            = "./encryption.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "network" {
  source            = "./network.sentinel"
  enforcement_level = "hard-mandatory"
}
