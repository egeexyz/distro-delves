terraform {
  backend "s3" {
    bucket = "eg-tfstate"
    key    = "delve.tfstate"
    region = "us-west-2"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
