mock "tfplan/v2" {
  module {
    source = "../../../tests/ec2/non-compliant-instance-type/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
