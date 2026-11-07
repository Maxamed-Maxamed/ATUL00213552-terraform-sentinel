mock "tfconfig/v2" {
  module {
    source = "../../../tests/supply_chain/compliant/mock-tfconfig-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}