resource "aws_iam_role" "lambda_response" {
  name = "image-resize-test-response"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = [
            "lambda.amazonaws.com",
            "edgelambda.amazonaws.com",
          ]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_response_01" {
  role       = aws_iam_role.lambda_response.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_response_02" {
  name = "s3-policy"
  role = aws_iam_role.lambda_response.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
        ]
        Resource = [
          "${aws_s3_bucket.image.arn}/*",
        ]
      }
    ]
  })
}
