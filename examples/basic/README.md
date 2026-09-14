# Basic DNS Example

Shows the module wired with custom domain and Route53 disabled, for plan-only use.

## What it creates

- With `enable_custom_domain = false` and `enable_route53 = false`, the module creates no resources.
- When enabled, it creates an `aws_route53_record` alias to CloudFront and an ACM certificate with its validation records.
- This example is a starting point. Set the flags, domain, and CloudFront values to turn it on.

## Before you start

- AWS provider, region `us-east-1`.
- The example sets mock credentials and skip flags. It is meant for `init` and `plan` offline.
- Replace the mock credentials with real ones before `apply`. A real run expects a Route53 hosted zone and a CloudFront distribution.

## Run it

```bash
terraform init
terraform plan
terraform apply
```

## Clean up

```bash
terraform destroy
```
