mock "tfplan/v2" {
  module {
    source = "../../../tests/encryption/compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}