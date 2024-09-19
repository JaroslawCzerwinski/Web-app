<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | 3.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_docker"></a> [docker](#provider\_docker) | 3.0.2 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [docker_container.web_app](https://registry.terraform.io/providers/kreuzwerker/docker/3.0.2/docs/resources/container) | resource |
| [docker_image.web_app](https://registry.terraform.io/providers/kreuzwerker/docker/3.0.2/docs/resources/image) | resource |
| [local_file.docker_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_web_app_version"></a> [web\_app\_version](#input\_web\_app\_version) | The version number of the web application to be deployed. | `string` | `"1.0.0"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->