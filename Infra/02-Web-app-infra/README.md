<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.68.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git | n/a |
| <a name="module_web_app_nlb"></a> [web\_app\_nlb](#module\_web\_app\_nlb) | git::https://github.com/terraform-aws-modules/terraform-aws-alb.git | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.web_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.web_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.web_app_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Region where to build infrastructure | `string` | `"eu-central-1"` | no |
| <a name="input_specific_IP"></a> [specific\_IP](#input\_specific\_IP) | Specific Ip address which will have SSH access to web app instance | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | The public IP address of the web application EC2 instance. |
| <a name="output_web_app_address"></a> [web\_app\_address](#output\_web\_app\_address) | The URL address of the web application, accessible via the Network Load Balancer (NLB). |
<!-- END_TF_DOCS -->