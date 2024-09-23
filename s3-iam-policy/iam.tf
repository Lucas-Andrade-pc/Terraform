resource "aws_iam_user" "lucao-user" {
  name = "lucao"
}
resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode(
    {
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                "s3:GetObject",
                ]
                Effect   = "Allow"
                Resource = [
                    "${aws_s3_bucket.teste.arn}", 
                    "${aws_s3_bucket.teste.arn}/*"
                ]
            },
        ]
    }
  )
}
resource "aws_iam_user_policy_attachment" "iam_policy" {
  policy_arn = aws_iam_policy.policy.arn
  user       = aws_iam_user.lucao-user.name
}
