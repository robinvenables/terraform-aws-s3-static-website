# terraform-aws-s3-static-website
Terraform scripts to build an AWS S3-hosted static website

## Description
These scripts build an AWS S3-hosted static website with the following components:

1. Two S3 buckets configured as websites, one named the same as the root domain name, the other with a www. prefix that redirects to the root domain name over HTTPS
2. Two AWS CloudFront distributions (CDN), one fronting each S3 bucket
3. Two Route 53 aliases, one for the root domain and one for the www. prefix, each pointing to the respective CDN
4. An ACM certificate for HTTPS

## Inputs

|Name|Description|Default Value|
|----|-----------|-------------|
|root_domain_name|The root domain name for this website. The www. subdomain will redirect to this||
|region|The AWS region this website will be created in (e.g. eu-west-2)||
|index_page|Name of the index document|index.html|
|error_page|Name of the error document|404.html|
|access_logging|Whether to enable logging for the website|false|
|logging_bucket_name|Name of the website logging bucket|none|
|logging_bucket_prefix|Prefix to use in the logging bucket|none|

## Outputs

|Name|Description|
|----|-----------|
|cloudfront_id|The CloudFront ID to deploy the website to|
