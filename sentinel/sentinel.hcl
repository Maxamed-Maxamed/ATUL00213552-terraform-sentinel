# Policy set configuration for the Sentinel CLI and for a policy set
# connected to version control.
#
# The enforcement levels below match what is deployed in HCP Terraform.
# The Free edition allows five policies in one policy set, and only one
# of them can be mandatory. That slot goes to sovereignty.
# On a paid edition all five would be hard-mandatory.

policy "sovereignty" {
  source            = "./sovereignty.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "supply_chain" {
  source            = "./supply_chain.sentinel"
  enforcement_level = "advisory"
}

policy "ec2" {
  source            = "./ec2.sentinel"
  enforcement_level = "advisory"
}

policy "encryption" {
  source            = "./encryption.sentinel"
  enforcement_level = "advisory"
}

policy "network" {
  source            = "./network.sentinel"
  enforcement_level = "advisory"
}
