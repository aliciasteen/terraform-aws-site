# Terraform for S3 CloudFront site

This Terraform module creates the following resources:
- S3 bucket
- CloudFront distribution
- SSL cert
- Route53 record

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
