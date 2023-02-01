module "dns_validated_certificate" {
  source  = "app.terraform.io/venables/dns-validated-certificate/aws"
  version = "1.0.0"

  dns_domain_name         = var.root_domain_name
  certificate_domain_name = var.root_domain_name
  certificate_san         = ["www.${var.root_domain_name}"]
  certificate_tags = {
    Name = var.root_domain_name
  }
  is_cloudfront_certificate = true
}

locals {
  certificate_arn = module.dns_validated_certificate.certificate_arn
}
