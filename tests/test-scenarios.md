# Sentinel Test Scenarios

## Purpose

This document explains the compliant and non-compliant mock scenarios used to test the six Sentinel policies.

Each policy has two tests:

- A compliant scenario expected to return `true`
- A non-compliant scenario expected to return `false`

The tests use local Sentinel mock data and do not deploy resources to AWS.

## 1. EBS encryption

Policy:

```text
sentinel/encryption.sentinel
```

### Compliant scenario

The mock represents an `aws_ebs_volume` with:

```text
encrypted = true
```

Expected result:

```text
true
```

### Non-compliant scenario

The mock represents an `aws_ebs_volume` with:

```text
encrypted = false
```

Expected result:

```text
false
```

The non-compliant scenario confirms that the policy rejects an unencrypted EBS volume.

## 2. EC2 instance type

Policy:

```text
sentinel/instance_type.sentinel
```

### Compliant scenario

The mock uses the approved instance type:

```text
t3.micro
```

Expected result:

```text
true
```

### Non-compliant scenario

The mock uses:

```text
m5.large
```

Expected result:

```text
false
```

The non-compliant scenario confirms that the policy rejects an instance type outside the approved list.

## 3. EC2 metadata and IMDSv2

Policy:

```text
sentinel/metadata.sentinel
```

### Compliant scenario

The mock uses:

```text
http_tokens = "required"
```

Expected result:

```text
true
```

### Non-compliant scenario

The mock uses:

```text
http_tokens = "optional"
```

Expected result:

```text
false
```

The non-compliant scenario confirms that the policy rejects an EC2 configuration that does not require IMDSv2.

## 4. Network security

Policy:

```text
sentinel/network.sentinel
```

### Compliant scenario

The mock represents a TCP ingress rule for port 22 with the source:

```text
10.0.0.0/24
```

Expected result:

```text
true
```

### Non-compliant scenario

The mock represents a TCP ingress rule for port 22 with the source:

```text
0.0.0.0/0
```

Expected result:

```text
false
```

The non-compliant scenario confirms that the policy rejects unrestricted inbound SSH from the IPv4 internet.

## 5. Digital sovereignty

Policy:

```text
sentinel/sovereignty.sentinel
```

### Compliant scenario

The mock uses the approved AWS Europe (Ireland) region:

```text
eu-west-1
```

Expected result:

```text
true
```

### Non-compliant scenario

The mock uses:

```text
us-east-1
```

Expected result:

```text
false
```

The non-compliant scenario confirms that the policy rejects a region outside the approved list.

This test covers the Terraform `aws_region` variable only. It does not prove that backups, logs, administrative access, or external services remain in Ireland.

## 6. Terraform supply-chain security

Policy:

```text
sentinel/supply_chain.sentinel
```

### Compliant scenario

The mock uses:

- Provider source `registry.terraform.io/hashicorp/aws`
- Provider constraint `~> 6.0`
- Module source beginning with `terraform-aws-modules/`
- A module version constraint

Expected result:

```text
true
```

### Non-compliant scenario

The mock uses:

- An unapproved provider publisher
- An unapproved provider constraint
- An untrusted module source
- An empty module version constraint

Expected result:

```text
false
```

The current Terraform configuration does not use an external module. The module rules were tested with `tfconfig/v2` mock data to show how the policy would behave if modules were added later.

## Complete test-suite result

The complete suite was run from the `sentinel` directory:

```powershell
sentinel test -verbose
```

The final result was:

```text
PASS - encryption.sentinel
PASS - instance_type.sentinel
PASS - metadata.sentinel
PASS - network.sentinel
PASS - sovereignty.sentinel
PASS - supply_chain.sentinel
6 tests completed
```

All compliant scenarios returned `true`, and all non-compliant scenarios returned `false`.