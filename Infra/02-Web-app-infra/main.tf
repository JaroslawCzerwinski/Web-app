resource "aws_key_pair" "web_app" {
  key_name   = "web_app_key"
  public_key = file("${path.module}/ssh_keys/web_app_key.pub")
}

resource "aws_security_group" "web_app_instance" {
  name        = "${local.name}-instance-SG"
  description = "Web app instance security group"
  vpc_id      = module.vpc.vpc_id

  ingress = [
    local.allow_http,
    local.allow_ssh
  ]

  egress = [
    local.allow_all
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-instance-SG"
  })
}

resource "aws_instance" "web_app" {
  ami           = "ami-00f07845aed8c0ee7" //al2023-ami-2023.5.20240916.0-kernel-6.1-x86_64
  subnet_id     = module.vpc.public_subnets[0]
  instance_type = "t3.micro"

  associate_public_ip_address = true

  key_name  = aws_key_pair.web_app.key_name
  user_data = file("${path.module}/script/user_data_script.sh")

  vpc_security_group_ids = [
    aws_security_group.web_app_instance.id
  ]

  tags = merge(local.tags, {
    ostype = "linux",
    Name   = "${local.name}-instance"
  })
}
