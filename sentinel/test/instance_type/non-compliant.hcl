mock "tfplan/v2" {
  module {
    source = "../../../tests/instance_type/non-compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}