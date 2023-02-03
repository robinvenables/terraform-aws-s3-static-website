variable "root_domain_name" {
  description = "The root domain name for this website. The www. subdomain will redirect to this"
  type        = string
}

variable "region" {
  description = "The AWS region this website will be created in (e.g. eu-west-2)"
  type        = string
}

variable "index_page" {
  description = "Name of the index page"
  type        = string
  default     = "index.html"
}

variable "error_page" {
  description = "Name of the error page"
  type        = string
  default     = "404.html"
}

variable "access_logging" {
  description = "Enable logging for the website"
  type        = bool
  default     = false
}

variable "logging_bucket_name" {
  description = "Name of the website logging bucket"
  type        = string
  default     = "none"
}

variable "logging_bucket_prefix" {
  description = "Prefix to use in the logging bucket"
  type        = string
  default     = "none"
}
