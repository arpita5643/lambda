
resource "aws_s3_bucket" "teraa" {
  # define the S3 bucket parameters here
}

resource "aws_iam_policy" "s3_access_policy" {
  # define the IAM policy parameters here
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
        ],
        Effect = "Allow",
        Resource = "${aws_s3_bucket.teraa.arn}/*",
      },
    ],
  })
}