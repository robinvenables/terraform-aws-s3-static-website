module "get_certificate" {
  source = "git@github.com:robinvenables/terraform-aws-dns-validated-certificate"

  dns_domain_name         = var.root_domain_name
  certificate_domain_name = var.root_domain_name
  certificate_san         = ["www.${var.root_domain_name}"]
  certificate_tags = {
    Name = var.root_domain_name
  }
  is_cloudfront_certificate = true
}

locals {
  certificate_arn = module.get_certificate.certificate_arn
}
