mock "tfplan/v2" {
  module {
    source = "../../../tests/ec2/non-compliant-imdsv1-allowed/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
