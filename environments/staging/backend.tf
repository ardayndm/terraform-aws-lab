terraform {
  backend "s3" {
    bucket       = "acme-terraform-state-870318142654-eu-north-1"
    key          = "acme/staging/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}
