mock "tfplan/v2" {
  module {
    source = "../../../tests/sovereignty/compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}