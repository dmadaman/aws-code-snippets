# General Settings
### You must have a credentials file OR use an IAM role from an ec2 instance
variable "shared_credentials_file" { default = "~/.aws/credentials" }
variable "region" { default = "us-west-2" }
variable "profile" { default = "default" }
variable "azs" { default = "us-west-2a,us-west-2b,us-west-2c" }
variable "azs_short" { default = "A,B,C"}
variable "enable_dns_hostnames" { default = "true" }
variable "enable_dns_support" { default = "true" }

# Provider Settings
provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file}"
  region                  = "${var.region}"
  profile                 = "${var.profile}"
}

# Main - to reference for VPC IDs, etc. Set to the same if you desire to reference from the same account
provider "aws" {
  alias                   = "main"
  shared_credentials_file = "${var.shared_credentials_file}"
  region                  = "${var.region}"
  profile                 = "default"
}

# S3 Configuration Options
variable "s3_region" { default = "us-west-2" }
### YOU MUST UPDATE THIS BUCKET AND ENSURE IT EXISTS
variable "tf_s3_bucket" { default = "CHANGEME" }
variable "acct_number" { default = "201035249631" }
