mock "tfplan/v2" {
  module {
    source = "../../../tests/network/compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}