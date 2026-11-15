mock "tfconfig/v2" {
  module {
    source = "../../../tests/supply_chain/non-compliant-module/mock-tfconfig-v2.sentinel"
  }
}

mock "tfplan/v2" {
  module {
    source = "../../../tests/supply_chain/non-compliant-module/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
