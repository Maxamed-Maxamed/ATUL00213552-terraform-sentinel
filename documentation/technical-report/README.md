# Technical Report: Terraform Policy-as-Code for Digital Sovereignty

## Overview

This project uses Terraform and HashiCorp Sentinel to test infrastructure requirements before deployment. The Terraform configuration describes a small AWS environment, while six Sentinel policies check EBS encryption, EC2 instance types, IMDSv2, unrestricted SSH access, AWS region, and Terraform dependency controls.

The policies were tested locally using compliant and non-compliant mock data. The final Sentinel test suite reported six successful policy test sets. No AWS resources were deployed as part of the policy testing.

## Design decisions

The approved AWS region is `eu-west-1`, which represents AWS Europe (Ireland). Restricting the Terraform `aws_region` variable creates a clear geographical rule for the resources represented in the plan.

The EC2 policy allows `t3.micro` and `t3.small` because the project represents a small demonstration environment. EBS volumes must be encrypted, and EC2 instances must require IMDSv2 through `http_tokens = "required"`.

The network policy rejects TCP port 22 when the IPv4 source is `0.0.0.0/0`. This prevents the tested security-group rule from allowing unrestricted SSH access from the IPv4 internet.

The supply-chain policy requires the HashiCorp AWS provider, the `~> 6.0` provider constraint, trusted module namespaces, and module version constraints. The Terraform configuration does not currently use an external module, so the module rules were evaluated using `tfconfig/v2` mock data.

## Evaluation

Sentinel was effective for requirements represented in Terraform configuration or plan data. The tests showed that approved values returned `true`, while the selected non-compliant values returned `false`. Storing the policies, mocks, screenshots, and Git history in the repository provides evidence of how each rule was tested.

The approach is preventive rather than continuous. Sentinel can evaluate the information available before deployment, but it does not monitor resources after they are created. Changes made manually in the AWS Console could create drift after the policy evaluation.

Region restriction also has limits. Selecting `eu-west-1` does not prove that backups, logs, support access, global services, or connected applications remain in Ireland. Digital sovereignty therefore requires more than a region policy.

Supply-chain checks have similar limits. The policy can check declared provider and module sources, but it cannot prove that dependency code is free from malicious behaviour. The Terraform lock file records provider selections and checksums, but remote modules require separate source and version review.

## Recommendations

A future version of the project could connect the repository to an HCP Terraform workspace and Sentinel policy set. Post-deployment monitoring could be added through AWS Config, AWS CloudTrail, and Terraform drift detection.

The network policy could also be expanded to cover inline security-group rules and unrestricted IPv6 access through `::/0`. Further sovereignty controls could examine backups, replication, KMS keys, public storage, and approved machine images.

These items are recommendations and are not part of the current implementation.

## Use of AI tools

Microsoft Copilot, powered by GPT-5.6, was used to explain commands, review Sentinel syntax, diagnose terminal errors, organise mock tests, and improve documentation clarity.

I ran the commands, reviewed the policy logic, corrected errors, captured the evidence, and managed the Git commits. Copilot suggestions were checked against the assignment requirements, terminal output, and official AWS and HashiCorp documentation.