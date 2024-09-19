locals {
  docker_config = jsondecode(data.local_file.docker_config.content)
  aws_ecr_url   = keys(local.docker_config.auths)[0]
}
