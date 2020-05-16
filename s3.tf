resource "aws_s3_bucket" "bucket" {
  bucket = var.website_name
  acl    = "private"
  policy = data.aws_iam_policy_document.bucket_policy.json
  tags = {
    Name = var.website_name
  }
  region = var.region
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.website_name}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

