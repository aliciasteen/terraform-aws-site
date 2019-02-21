provider "aws" {
  region = "eu-west-1"
}


resource "aws_s3_bucket" "bucket" {
  bucket = "${var.website_name}"
  acl = "private"
  tags = {
      Name = "${var.website_name}"
  }
}

locals {
  s3_origin_id = "S3-Bucket"
}


resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
      domain_name = "${aws_s3_bucket.bucket.bucket_regional_domain_name}"
      origin_id = "${var.website_name}"

      s3_origin_config {
          origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
      }
  }
  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  price_class = "${var.price_class}"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "rediect_to_https"
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.site_certificate.arn}"
    ssl_support_method = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  
}

resource "aws_acm_certificate" "site_certificate" {
  domain = "${var.website_name}"
  provider = "aws.usest1"
  validation_method = "DNS"
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "site_certificate_validation" {
  provider = "aws.useast1"
  certificate_arn = "${aws_acm_certificate.site_certificate.arn}"
  validation_record_fqdns = ["${aws_route53_record.site_certificate_validation_record.fqdn}"]
  
}
