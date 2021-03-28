resource "aws_cloudfront_origin_access_identity" "image" {
  comment = "origin access identity for s3"
}

resource "aws_cloudfront_distribution" "image" {
  origin {
    domain_name = aws_s3_bucket.image.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.image.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.image.cloudfront_access_identity_path
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  comment         = "Image test"

  price_class = "PriceClass_200"

  aliases = [] // 今回はCloudfrontのドメインを使用するので何も記述しません

  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
    ]
    cached_methods = [
      "GET",
      "HEAD",
    ]
    target_origin_id = aws_s3_bucket.image.id

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = [
        "JP",
      ]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1.2_2019"
  }
}