mock "tfplan/v2" {
  module {
    source = "../../../tests/network/non-compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}