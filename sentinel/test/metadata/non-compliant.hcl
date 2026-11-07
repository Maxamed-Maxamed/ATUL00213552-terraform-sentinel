mock "tfplan/v2" {
  module {
    source = "../../../tests/metadata/non-compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}