data "terraform_remote_state" "core" {
  backend = "s3"
  config = {
    bucket = "web-app-jarekc-terraform-state"
    key    = "core.tfstate"
    region = "eu-central-1"
  }
}

data "local_file" "docker_config" {
  filename = pathexpand("~/.docker/config.json")
}

resource "docker_image" "web_app" {
  name = "${data.terraform_remote_state.core.outputs.web_app_ecr_repo_uri}:${var.web_app_version}"
}

resource "docker_container" "web_app" {
  name     = "web_app"
  image    = docker_image.web_app.image_id
  must_run = true

  ports {
    internal = 80
    external = 80
  }
}