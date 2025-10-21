
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  object_lock_enabled = true

  tags = {
    Name        = var.bucket_name
    Env         = var.environment
  }
}


resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_object" "object" {
  depends_on = [aws_s3_bucket_versioning.bucket_versioning]

  bucket    = aws_s3_bucket.bucket.id
  key       = var.object_name
  source    = var.config_filename

  etag = filemd5(var.config_filename)

  force_destroy = var.force_destroy
}
