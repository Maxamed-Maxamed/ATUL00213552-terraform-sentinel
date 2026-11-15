# Technical Report: Final Limitations and Recommendations

**Student:** ATUL00213552. **Project:** Policy as Code for digital sovereignty and Terraform supply chain security.

## What was delivered

Five Sentinel policies run in HCP Terraform on every plan for the workspace. A compliant plan (7 resources) passed all five. A deliberately non-compliant plan (10 resources) was stopped by the hard mandatory sovereignty policy, with three advisory failures reported. Locally, 22 test cases pass against mock data downloaded from those two real plans.

## Final limitations

1. **Region is not jurisdiction.** The policy proves that planned resources are in `eu-west-1`. AWS is still a United States company and can be compelled under the US CLOUD Act to produce data it controls, wherever it is stored. The framework delivers data residency, not full sovereignty.
2. **Only one policy can block.** The HCP Terraform Free edition allows one mandatory policy, and sovereignty has it. Encryption, network, EC2 and supply chain failures are reported but do not stop a run.
3. **The deployed policies are copies.** The Free edition cannot connect a policy set to GitHub, so the code was pasted in and can drift from the repository.
4. **Sentinel sees only the plan.** Unknown values, console changes, drift, the provider version actually installed and the contents of a provider or module are outside its view. It cannot read the lock file.
5. **Coverage depends on the author.** My first policies passed their own hand-written tests and still missed the root volume, inline security group rules and the per resource `region` argument added in AWS provider 6.
6. **The gate can be bypassed.** GitHub allows the failing pull request to be merged, and anyone with AWS credentials can apply from a laptop.
7. **Module and provider failures were tested with mocks only.** The configuration has no external module and the non-compliant run kept the approved provider.

## Recommendations

1. Use an edition that allows all five policies to be hard mandatory and connects the policy set to the repository.
2. Require the HCP Terraform and CI checks through a branch protection rule on `main`, and remove direct AWS credentials from developers.
3. Add runtime controls: a service control policy denying every region except `eu-west-1`, AWS Config rules for encryption and open security groups, CloudTrail for administrative access, and drift detection.
4. Hold customer managed KMS keys in Ireland for sensitive data, and assess a European operated provider where US jurisdiction is not acceptable.
5. Allow replication only when the destination is an approved region, in place of blocking it outright.
6. Pin the AMI to a reviewed image ID and tighten the provider constraint to one minor release.
7. Regenerate mock data from a real plan and review the policies at every provider upgrade.

## Use of AI tools

Microsoft Copilot (GPT-5.6) explained commands and reviewed syntax in the first version. Claude (Anthropic, Claude Fable 5.2) reviewed the first submission, guided the HCP Terraform setup, wrote the revised policies and tests, and drafted the documentation. I ran every command, built the HCP Terraform configuration, captured the evidence and made the design decisions. Prompts are listed in the main README.
