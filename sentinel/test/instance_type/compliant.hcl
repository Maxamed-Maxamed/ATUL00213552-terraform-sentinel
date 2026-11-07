mock "tfplan/v2" {
  module {
    source = "../../../tests/instance_type/compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}