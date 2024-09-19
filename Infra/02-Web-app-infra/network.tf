module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git"

  name = local.name
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a"]
  public_subnets  = ["10.0.1.0/24"]
  private_subnets = ["10.0.11.0/24"]

  public_dedicated_network_acl = true

  manage_default_network_acl = false

  public_inbound_acl_rules  = concat(local.network_acls["default_inbound"])
  public_outbound_acl_rules = concat(local.network_acls["default_outbound"])

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true

  vpc_tags = {
    Name = "vpc-${local.name}"
  }
}

module "web_app_nlb" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git"

  name                       = "${local.name}-NLB"
  load_balancer_type         = "network"
  enable_deletion_protection = false

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  security_group_ingress_rules = {
    all_tcp = {
      from_port   = 0
      to_port     = 65535
      ip_protocol = "tcp"
      description = "Allow all inbound TCP traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all = {
      from_port   = local.web_app_port
      to_port     = local.web_app_port
      ip_protocol = "tcp"
      cidr_ipv4   = "${aws_instance.web_app.private_ip}/32"
    }
  }

  listeners = {
    web-app = {
      port     = local.web_app_port
      protocol = "TCP"
      forward = {
        target_group_key = "web-app"
      }
    }
  }

  target_groups = {
    web-app = {
      name_prefix          = "t1-"
      protocol             = "TCP"
      port                 = local.web_app_port
      target_type          = "ip"
      target_id            = aws_instance.web_app.private_ip
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 15
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 6
      }
    }
  }
  tags = local.tags
}
