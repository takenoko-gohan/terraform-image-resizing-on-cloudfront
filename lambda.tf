resource "aws_lambda_function" "nodejs_response" {
  provider         = aws.global
  filename         = data.archive_file.dummy.output_path
  function_name    = "image-resize-test-nodejs-response"
  role             = aws_iam_role.lambda_response.arn
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

resource "aws_lambda_function" "wasm_response" {
  provider         = aws.global
  filename         = data.archive_file.dummy.output_path
  function_name    = "image-resize-test-wasm-response"
  role             = aws_iam_role.lambda_response.arn
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
