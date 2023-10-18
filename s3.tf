resource "aws_s3_bucket" "root_site_bucket" {
  bucket = var.root_domain_name
}

resource "aws_s3_bucket_ownership_controls" "root_site_ownership_controls" {
  bucket = aws_s3_bucket.root_site_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "root_site_public_access_block" {
  bucket = aws_s3_bucket.root_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "root_site_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.root_site_ownership_controls,
    aws_s3_bucket_public_access_block.root_site_public_access_block,
  ]

  bucket = aws_s3_bucket.root_site_bucket.id
  acl = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "root_site_encryption_configuration" {
  bucket = aws_s3_bucket.root_site_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "root_site_website_configuration" {
  bucket = aws_s3_bucket.root_site_bucket.id

  index_document {
    suffix = var.index_page
  }

  error_document {
    key = var.error_page
  }
}

resource "aws_s3_bucket_logging" "root_site_logging" {
  bucket = aws_s3_bucket.root_site_bucket.id

  count = var.access_logging ? 1 : 0

  target_bucket = var.logging_bucket_name
  target_prefix = var.logging_bucket_prefix
}

resource "aws_s3_bucket" "www_site_bucket" {
  bucket = "www.${var.root_domain_name}"
}

resource "aws_s3_bucket_ownership_controls" "www_site_ownership_controls" {
  bucket = aws_s3_bucket.www_site_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "www_site_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.www_site_ownership_controls]
  
  bucket = aws_s3_bucket.www_site_bucket.id
  acl = "private"
}

resource "aws_s3_bucket_website_configuration" "www_site_website_configuration" {
  bucket = aws_s3_bucket.www_site_bucket.id

  redirect_all_requests_to {
    host_name = var.root_domain_name
    protocol  = "https"
  }
}
