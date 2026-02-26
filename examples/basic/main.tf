provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock"
  secret_key                  = "mock"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_region_validation      = true
}

module "dns" {
  source = "../.."

  enable_custom_domain      = false
  enable_route53            = false
  domain_name               = null
  full_domain               = null
  app_name                  = "example"
  cloudfront_domain_name    = "d111111abcdef8.cloudfront.net"
  cloudfront_hosted_zone_id = "Z2FDTNDATAQYW2"
}
