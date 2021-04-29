resource "aws_lambda_function" "nodejs" {
  provider         = aws.global
  filename         = data.archive_file.dummy.output_path
  function_name    = "${var.prefix}-image-resize-nodejs"
  role             = aws_iam_role.lambda.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.dummy.output_base64sha256
  runtime          = "nodejs12.x"

  publish = true

  memory_size = 1024
  timeout     = 30

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash,
    ]
  }
}

resource "aws_lambda_function" "wasm" {
  provider         = aws.global
  filename         = data.archive_file.dummy.output_path
  function_name    = "${var.prefix}-image-resize-wasm"
  role             = aws_iam_role.lambda.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.dummy.output_base64sha256
  runtime          = "nodejs12.x"

  publish = true

  memory_size = 1024
  timeout     = 30

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash,
    ]
  }
}
