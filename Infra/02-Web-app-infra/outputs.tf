output "instance_public_ip" {
  value       = aws_instance.web_app.public_ip
  description = "The public IP address of the web application EC2 instance."
}

output "web_app_address" {
  value       = "http://${module.web_app_nlb.dns_name}"
  description = "The URL address of the web application, accessible via the Network Load Balancer (NLB)."
}
