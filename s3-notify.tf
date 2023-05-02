resource "aws_s3_bucket_notification" "example_bucket_notification" {
  bucket = aws_s3_bucket.example_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.example_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
}