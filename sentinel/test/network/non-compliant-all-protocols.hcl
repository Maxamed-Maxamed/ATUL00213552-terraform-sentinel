mock "tfplan/v2" {
  module {
    source = "../../../tests/network/non-compliant-all-protocols/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
