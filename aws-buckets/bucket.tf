resource "aws_s3_bucket" "create-bucket" {
  bucket = var.name_bucket

  tags = {
    Name = "s3-state"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.create-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}