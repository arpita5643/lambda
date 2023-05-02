
data "archive_file" "lambda_function_file" {
  type = "zip"
  source_file = "index.js"
  output_path = "lambda_function.zip"
}


resource "aws_lambda_function" "func" {
  function_name = "my-lambda-function"
  handler = "index.handler"
  runtime = "nodejs14.x"
  role         = "arn:aws:iam::123456789012:role/lambda-execution-role"
  filename      = "lambda_function.zip"
  source_code_hash = data.archive_file.lambda_function_file.output_base64sha256

}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  
  // replace my-bucket with the name of your S3 bucket
  source_arn    = "arn:aws:s3:::my-bucket"
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-name"

}
