resource "aws_s3_bucket" "teste" {
  bucket = "sfqd2q1r42fw"
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.teste.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.teste.id
  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                  "AWS": "${aws_iam_user.lucao-user.arn}"
                },
                "Action": [
                    "s3:GetObject",
                    "s3:PutObject"
                ],
                "Resource": ["${aws_s3_bucket.teste.arn}", "${aws_s3_bucket.teste.arn}/*"]
            }
        ]
    }
  EOF
}
