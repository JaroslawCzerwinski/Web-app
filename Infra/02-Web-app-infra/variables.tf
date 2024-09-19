variable "region" {
  description = "Region where to build infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "specific_IP" {
  description = "Specific Ip address which will have SSH access to web app instance"
  type        = string
}