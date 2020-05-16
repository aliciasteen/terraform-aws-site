# Terraform for S3 CloudFront site

This Terraform module creates the following resources:
- S3 bucket
- CloudFront distribution
- SSL cert
- Route53 record (optional)

## Usage
```
provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias = "useast1"
  region = "us-east-1"
}

module "cloudfront_site" {
  source = "git::https://github.com/aliciasteen/terraform-aws-site.git"

  providers {
      aws.useast1 = "aws.useast1"
  }

  website_name = "site"
  hosted_zone_id = "zone_id"
  region = "eu-west-1"
  price_class = "PriceClass_100"
}

```
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.useast1 | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name | Name of S3 bucket to create | `string` | n/a | yes |
| website\_name | Website alias for cloudfront | `string` | n/a | yes |
| hosted\_zone\_id | Hosted zone id for domain name (optional) | `string` | `""` | no |
| price\_class | AWS Cloudfront price class. One of PriceClass\_All, PriceClass\_200, PriceClass\_100 | `string` | `"PriceClass_All"` | no |
| region | AWS Region to create bucket in | `string` | `"eu-west-1"` | no |
| route53-enabled | Use route53 for DNS? | `bool` | `true` | no |
