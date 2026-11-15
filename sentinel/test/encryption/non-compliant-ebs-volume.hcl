mock "tfplan/v2" {
  module {
    source = "../../../tests/encryption/non-compliant-ebs-volume/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
