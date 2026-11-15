# Sentinel Test Scenarios

This document lists every test case for the five Sentinel policies. The test files are in `sentinel/test/<policy>/` and the mock data is in `tests/`.

There are three kinds of mock data:

- **HCP compliant.** Downloaded from the HCP Terraform plan of the `main` branch (7 resources). Stored in `tests/hcp-mocks/compliant/`.
- **HCP non-compliant.** Downloaded from the HCP Terraform plan of the `demo/non-compliant` branch (10 resources). Stored in `tests/hcp-mocks/non-compliant/`.
- **Focused mocks.** Small hand-written files in `tests/<policy>/`, each containing one resource that breaks one rule. They use the same structure as the real plan data.

A test passes when the policy returns the expected value. A non-compliant test that shows `PASS` means the policy correctly returned `false`.

## sovereignty.sentinel

| Test file | Mock data | Expected | What it proves |
|---|---|---|---|
| `hcp-compliant.hcl` | HCP compliant | `true` | All 7 real resources are in `eu-west-1` and the sensitive instance has its residency tag |
| `hcp-non-compliant.hcl` | HCP non-compliant | `false` | The real plan with a volume in `us-east-1` is rejected |
| `non-compliant-region.hcl` | Instance with `region = "us-east-1"` | `false` | A single resource outside Ireland fails, even though the region variable is unchanged |
| `non-compliant-sensitive-tag.hcl` | Sensitive instance with no `DataResidency` tag | `false` | Sensitive resources must declare Irish residency |
| `non-compliant-replication.hcl` | `aws_ebs_snapshot_copy` in `eu-west-1` | `false` | Copy and replication resources are blocked wherever they are |

## supply_chain.sentinel

| Test file | Mock data | Expected | What it proves |
|---|---|---|---|
| `hcp-compliant.hcl` | HCP compliant, plan and configuration | `true` | The real configuration uses `hashicorp/aws` with `~> 6.0` and no modules |
| `compliant-module.hcl` | `terraform-aws-modules/vpc/aws` at `6.0.1` | `true` | A trusted module pinned to an exact version is accepted |
| `non-compliant-provider.hcl` | Provider `untrusted/aws` with `>= 4.0` | `false` | An unapproved provider source and constraint are rejected |
| `non-compliant-module.hcl` | `untrusted-example/vpc/aws` with `>= 5.0` | `false` | An untrusted module and a version range are rejected |

The non-compliant HCP Terraform plan is not used for this policy. The demo file keeps the approved provider, so the policy correctly passes on that plan.

## ec2.sentinel

| Test file | Mock data | Expected | What it proves |
|---|---|---|---|
| `hcp-compliant.hcl` | HCP compliant | `true` | The real instance is `t3.micro` and requires IMDSv2 |
| `hcp-non-compliant.hcl` | HCP non-compliant | `false` | The real `m5.large` instance with IMDSv1 allowed is rejected |
| `non-compliant-instance-type.hcl` | Instance of type `m5.large` | `false` | Only approved instance types pass |
| `non-compliant-imdsv1-allowed.hcl` | Instance with `http_tokens = "optional"` | `false` | IMDSv2 is mandatory |

## encryption.sentinel

| Test file | Mock data | Expected | What it proves |
|---|---|---|---|
| `hcp-compliant.hcl` | HCP compliant | `true` | The real instance declares an encrypted root volume |
| `hcp-non-compliant.hcl` | HCP non-compliant | `false` | The real unencrypted volume and root volume are rejected |
| `non-compliant-root-volume.hcl` | Instance with an unencrypted root volume | `false` | Volumes declared inside an instance are checked |
| `non-compliant-ebs-volume.hcl` | `aws_ebs_volume` with `encrypted = false` | `false` | Standalone volumes are checked |

## network.sentinel

| Test file | Mock data | Expected | What it proves |
|---|---|---|---|
| `hcp-compliant.hcl` | HCP compliant | `true` | The real security group has no inbound rules |
| `hcp-non-compliant.hcl` | HCP non-compliant | `false` | The real ingress rule opening SSH to `0.0.0.0/0` is rejected |
| `non-compliant-inline-ssh.hcl` | Inline ingress block, TCP 22 from `0.0.0.0/0` | `false` | Inline rules inside `aws_security_group` are checked |
| `non-compliant-all-protocols.hcl` | Ingress rule with protocol `-1` from `0.0.0.0/0` | `false` | A rule allowing all traffic counts as allowing SSH |
| `non-compliant-ipv6-ssh.hcl` | Ingress rule, TCP 22 from `::/0` | `false` | IPv6 is checked as well as IPv4 |

## Running the tests

```powershell
cd sentinel
sentinel test
```

Expected result: five policies pass, 22 test cases in total.
