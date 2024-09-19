locals {
  name                = "web-app-jarekc-terraform-state"
  dynamodb_table_name = "web-app-lock-table"

  tags = {
    Name = local.name
  }
}