terraform {
  backend "s3" {
    bucket = "interal-platform-statefile-jenkins"
    key = var.key
    region = "ap-south-1"
  }
}
