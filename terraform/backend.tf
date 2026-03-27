terraform {
  required_version = ">= 1.6.3"

  backend "s3" {
    endpoints = {
      s3 = "https://tor1.digitaloceanspaces.com"
    }

    bucket = "spacebucket3000"
    key    = "terraform-cm.tfstate"

    # Deactivate a few AWS-specific checks
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    region                      = "us-east-1"
  }
}
