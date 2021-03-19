resource "aws_cloudfront_distribution" "s3_distribution" {
    enabled             = true
    is_ipv6_enabled     = true
    comment             = "Voidwalker CDN"
    default_root_object = "index.html"


    origin {
        domain_name = aws_s3_bucket.site_bucket.bucket_regional_domain_name
        origin_id   = local.s3_origin_id
    }

    viewer_certificate {
    cloudfront_default_certificate = true
    }

    default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      cookies {
          forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA"]
    }
  }
}