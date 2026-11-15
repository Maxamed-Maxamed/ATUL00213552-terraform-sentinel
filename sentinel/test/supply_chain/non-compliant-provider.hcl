mock "tfconfig/v2" {
  module {
    source = "../../../tests/supply_chain/non-compliant-provider/mock-tfconfig-v2.sentinel"
  }
}

mock "tfplan/v2" {
  module {
    source = "../../../tests/supply_chain/non-compliant-provider/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
