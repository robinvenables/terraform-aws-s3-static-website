resource "aws_s3_bucket" "root_site_bucket" {
  bucket = var.root_domain_name
}

resource "aws_s3_bucket_acl" "root_site_acl" {
  bucket = aws_s3_bucket.root_site_bucket.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "root_site_policy" {
  bucket = aws_s3_bucket.root_site_bucket.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.root_domain_name}/*"
            ]
        }
    ]
}
POLICY
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
    suffix = var.pages.index
  }

  error_document {
    key = var.pages.error
  }
}

resource "aws_s3_bucket_logging" "root_site_logging" {
  bucket = aws_s3_bucket.root_site_bucket.id

  count = var.access_logging ? 1 : 0

  target_bucket = var.logging_bucket.name
  target_prefix = var.logging_bucket.prefix
}

resource "aws_s3_bucket" "www_site_bucket" {
  bucket = "www.${var.root_domain_name}"
}

resource "aws_s3_bucket_acl" "www_site_acl" {
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
