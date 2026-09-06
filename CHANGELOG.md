# Changelog

All notable changes to this module are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- `certificate_arn` input — attach an existing ACM certificate instead of requesting one. Skips the certificate request, the validation record, and the validation wait. Enables reusing a shared or wildcard certificate, and standing up a site whose domain is not yet delegated to Route53.

## [v0.2.2] - 2026-09-05

### Added

- terraform-docs-generated interface documentation in README (Requirements/Providers/Inputs/Outputs) with a CI drift check.

## [v0.2.1] - 2026-09-05

### Added

- CHANGELOG.md.

## [v0.2.0] - 2026-09-04

### Added

- CI and release workflows.
- `.tflint.hcl` configuration.
- MIT LICENSE.
- README badges.
- Example terraform block.
- Committed Terraform lock files.

### Changed

- AWS provider constraint to `>= 5.0, < 7.0`.

> Historical releases are documented in [GitHub Releases](https://github.com/pomo-studio/terraform-aws-ssr-dns/releases).
