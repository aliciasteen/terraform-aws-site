variable "website_name" {
  type = "string"
  default = "website"
}

variable "region" {
  type = "string"
  description = "AWS Region to create bucket in"
  default = "eu-west-1"
}

variable "price_class" {
    type = "string"
    description = "AWS Cloudfront price class. One of PriceClass_All, PriceClass_200, PriceClass_100"
    default = "PriceClass_All"
}
