mock "tfplan/v2" {
  module {
    source = "../../../tests/encryption/non-compliant-root-volume/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
