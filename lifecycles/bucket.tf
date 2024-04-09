resource "aws_s3_bucket" "create-bucket" {
  bucket = var.name_bucket
  lifecycle {
    create_before_destroy = true
    ignore_changes = [ 
      tags
     ]
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.create-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}