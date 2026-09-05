# terraform-aws-ssr-dns

[![Terraform Validation](https://github.com/pomo-studio/terraform-aws-ssr-dns/actions/workflows/terraform.yml/badge.svg)](https://github.com/pomo-studio/terraform-aws-ssr-dns/actions/workflows/terraform.yml)
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-844FBA?logo=terraform)](https://registry.terraform.io/modules/pomo-studio/ssr-dns/aws)

- [Changelog](CHANGELOG.md)

Reusable DNS and ACM module for SSR stacks.

This module manages Route53 alias records and ACM certificate issuance/validation for custom domains.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0, < 7.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application name for resource naming | `string` | n/a | yes |
| <a name="input_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#input\_cloudfront\_domain\_name) | CloudFront domain name for alias record | `string` | n/a | yes |
| <a name="input_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#input\_cloudfront\_hosted\_zone\_id) | CloudFront hosted zone id for alias record | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags | `map(string)` | `{}` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Base domain name | `string` | `null` | no |
| <a name="input_enable_custom_domain"></a> [enable\_custom\_domain](#input\_enable\_custom\_domain) | Whether custom domain resources are enabled | `bool` | n/a | yes |
| <a name="input_enable_route53"></a> [enable\_route53](#input\_enable\_route53) | Whether Route53-managed DNS resources are enabled | `bool` | n/a | yes |
| <a name="input_full_domain"></a> [full\_domain](#input\_full\_domain) | Computed full domain for certificate and records | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | ACM certificate ARN |
| <a name="output_dns_cloudfront_record"></a> [dns\_cloudfront\_record](#output\_dns\_cloudfront\_record) | DNS record values for manual CloudFront configuration |
| <a name="output_dns_validation_records"></a> [dns\_validation\_records](#output\_dns\_validation\_records) | DNS records for ACM certificate validation |
<!-- END_TF_DOCS -->
