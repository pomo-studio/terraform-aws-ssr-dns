variable "enable_custom_domain" {
  description = "Whether custom domain resources are enabled"
  type        = bool
}

variable "enable_route53" {
  description = "Whether Route53-managed DNS resources are enabled"
  type        = bool
}

variable "domain_name" {
  description = "Base domain name"
  type        = string
  default     = null
}

variable "full_domain" {
  description = "Computed full domain for certificate and records"
  type        = string
  default     = null
}

variable "certificate_arn" {
  description = "ARN of an existing ACM certificate covering the full domain. When set, the module attaches this certificate instead of requesting and validating its own. Must be in us-east-1 for CloudFront."
  type        = string
  default     = null

  validation {
    condition     = var.certificate_arn == null || can(regex("^arn:aws[a-z-]*:acm:us-east-1:[0-9]{12}:certificate/.+$", var.certificate_arn))
    error_message = "certificate_arn must be an ACM certificate ARN in us-east-1 (CloudFront only accepts certificates from that region)."
  }
}

variable "app_name" {
  description = "Application name for resource naming"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "cloudfront_domain_name" {
  description = "CloudFront domain name for alias record"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "CloudFront hosted zone id for alias record"
  type        = string
}
