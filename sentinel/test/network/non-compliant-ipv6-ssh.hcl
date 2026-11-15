mock "tfplan/v2" {
  module {
    source = "../../../tests/network/non-compliant-ipv6-ssh/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
