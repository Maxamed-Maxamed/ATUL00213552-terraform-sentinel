mock "tfplan/v2" {
  module {
    source = "../../../tests/metadata/compliant/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}