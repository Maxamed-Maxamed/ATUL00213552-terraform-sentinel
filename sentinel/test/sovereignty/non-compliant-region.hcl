mock "tfplan/v2" {
  module {
    source = "../../../tests/sovereignty/non-compliant-region/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
