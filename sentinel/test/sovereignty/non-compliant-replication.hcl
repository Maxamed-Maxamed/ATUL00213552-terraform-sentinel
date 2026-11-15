mock "tfplan/v2" {
  module {
    source = "../../../tests/sovereignty/non-compliant-replication/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
