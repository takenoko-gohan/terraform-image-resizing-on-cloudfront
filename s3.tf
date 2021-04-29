resource "aws_s3_bucket" "image" {
  bucket        = "${var.prefix}-test-images"
  acl           = "private"
  force_destroy = true // 今回は検証環境なので強制削除できるようにします
}

resource "aws_s3_bucket_policy" "image" {
  bucket = aws_s3_bucket.image.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "cloudfront"
    Statement = [
      {
        Sid    = "CloudfrontAllow"
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.image.iam_arn
        }
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
        ]
        Resource = [
          aws_s3_bucket.image.arn,
          "${aws_s3_bucket.image.arn}/*",
        ]
      },
    ]
  })
}