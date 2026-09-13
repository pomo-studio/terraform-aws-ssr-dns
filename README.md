# terraform-aws-ssr-dns

[![Terraform Validation](https://github.com/pomo-studio/terraform-aws-ssr-dns/actions/workflows/terraform.yml/badge.svg)](https://github.com/pomo-studio/terraform-aws-ssr-dns/actions/workflows/terraform.yml)
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-844FBA?logo=terraform)](https://registry.terraform.io/modules/pomo-studio/ssr-dns/aws)

[Changelog](CHANGELOG.md)

Route 53 and ACM for a server-rendered site: issue and validate a certificate, then point a custom domain at CloudFront.

## When to use it

Give a CloudFront distribution a custom domain: request and validate an ACM certificate, then create the Route 53 alias record that points the domain at it. The distribution does not have to be server-rendered, so reach for this whenever a CDN endpoint needs a real domain name.

It is also the DNS and certificate layer of the [Serverless SSR blueprint](https://registry.terraform.io/modules/pomo-studio/serverless-ssr/aws).

The bring-your-own path matters in two cases: a shared or wildcard certificate already covers the domain, or the domain is not yet delegated to Route 53. In the second case the module's own validation record would be written to a zone nothing queries, so validation could never succeed.

CloudFront accepts certificates only from `us-east-1`; the module validates the region rather than letting the apply fail late.

## Quickstart

```hcl
module "dns" {
  source  = "pomo-studio/ssr-dns/aws"
  version = "~> 0.3"

  enable_custom_domain = true
  enable_route53       = true
  domain_name          = "example.com"
  full_domain          = "www.example.com"

  app_name                  = "example"
  cloudfront_domain_name    = module.cloudfront.domain_name
  cloudfront_hosted_zone_id = module.cloudfront.hosted_zone_id
}
```

To attach an existing certificate, set `certificate_arn` and leave the rest unchanged.

## What it creates

- An ACM certificate for `full_domain`, and its validation.
- The Route 53 validation record ACM reads.
- The Route 53 alias record that points the domain at CloudFront.
- A data lookup of the hosted zone.

With `certificate_arn` set, it creates only the alias record.

## Design decisions

- **Issue by default, attach on request.** The common path is automatic. `certificate_arn` disables issuance and validation for the cases that cannot use it.
- **Validation through Route 53.** DNS validation renews without manual steps, as long as the zone is authoritative.
- **Undelegated domains are a first-class case.** Attaching an existing certificate is the only safe path when the domain's nameservers live elsewhere.
- **us-east-1 enforced.** CloudFront rejects certificates from any other region, so a wrong-region ARN fails immediately.

## Examples

- [Basic](examples/basic/)

## Reference

<details>
<summary>Reference</summary>

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0, < 7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application name for resource naming | `string` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN of an existing ACM certificate covering the full domain. When set, the module attaches this certificate instead of requesting and validating its own. Must be in us-east-1 for CloudFront. | `string` | `null` | no |
| <a name="input_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#input\_cloudfront\_domain\_name) | CloudFront domain name for alias record | `string` | n/a | yes |
| <a name="input_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#input\_cloudfront\_hosted\_zone\_id) | CloudFront hosted zone id for alias record | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags | `map(string)` | `{}` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Base domain name | `string` | `null` | no |
| <a name="input_enable_custom_domain"></a> [enable\_custom\_domain](#input\_enable\_custom\_domain) | Whether custom domain resources are enabled | `bool` | n/a | yes |
| <a name="input_enable_route53"></a> [enable\_route53](#input\_enable\_route53) | Whether Route53-managed DNS resources are enabled | `bool` | n/a | yes |
| <a name="input_full_domain"></a> [full\_domain](#input\_full\_domain) | Computed full domain for certificate and records | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | ACM certificate ARN |
| <a name="output_dns_cloudfront_record"></a> [dns\_cloudfront\_record](#output\_dns\_cloudfront\_record) | DNS record values for manual CloudFront configuration |
| <a name="output_dns_validation_records"></a> [dns\_validation\_records](#output\_dns\_validation\_records) | DNS records for ACM certificate validation |
<!-- END_TF_DOCS -->

</details>

## Support and license

Part of the [pomo-studio](https://github.com/pomo-studio) Terraform components, run in production by [postmodern.](https://pomo.studio). Regenerate the reference with `terraform-docs` v0.20.0 (`terraform-docs .`); CI fails on drift.

See the [contribution guide](https://github.com/pomo-studio/.github/blob/main/CONTRIBUTING.md) and [security policy](https://github.com/pomo-studio/.github/blob/main/SECURITY.md).

MIT licensed. See [LICENSE](LICENSE).
