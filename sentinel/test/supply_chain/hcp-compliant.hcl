mock "tfconfig/v2" {
  module {
    source = "../../../tests/hcp-mocks/compliant/mock-tfconfig-v2.sentinel"
  }
}

mock "tfplan/v2" {
  module {
    source = "../../../tests/hcp-mocks/compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
