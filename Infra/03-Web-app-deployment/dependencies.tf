terraform {
  required_version = "~> 1.2"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
  backend "s3" {
    key            = "web-app-deployment.tfstate"
    bucket         = "web-app-jarekc-terraform-state"
    dynamodb_table = "web-app-lock-table"
    region         = "eu-central-1"
    encrypt        = true
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
  registry_auth {
    address     = local.aws_ecr_url
    config_file = pathexpand("~/.docker/config.json")
  }
}
