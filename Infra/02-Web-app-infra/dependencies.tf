terraform {
  required_version = "~> 1.2"
  required_providers {
    aws = {
      version = "~> 5.0"
    }
  }
  backend "s3" {
    key            = "web-app-infra.tfstate"
    bucket         = "web-app-jarekc-terraform-state"
    dynamodb_table = "web-app-lock-table"
    region         = "eu-central-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project = "Web-app"
    }
  }
}
