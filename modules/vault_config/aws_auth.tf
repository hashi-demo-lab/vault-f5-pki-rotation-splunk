locals {
  my_email = split("/", data.aws_caller_identity.current.arn)[2]
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Vault Mount AWS Config Setup

data "aws_iam_policy" "demo_user_permissions_boundary" {
  name = "DemoUser"
}

resource "aws_iam_user" "vault_mount_user" {
  name                 = "demo-${local.my_email}"
  permissions_boundary = data.aws_iam_policy.demo_user_permissions_boundary.arn
  force_destroy        = true
}

/* resource "aws_iam_user_policy" "vault_mount_user" {
#  user   = aws_iam_user.vault_mount_user.name
#  policy = data.aws_iam_policy.demo_user_permissions_boundary.policy
#  name   = "DemoUserInlinePolicy"
} */

resource "aws_iam_user_policy_attachment" "vault_mount_user" {
  user   = aws_iam_user.vault_mount_user.name
  policy_arn = data.aws_iam_policy.demo_user_permissions_boundary.arn
}


resource "aws_iam_access_key" "vault_mount_user" {
  user = aws_iam_user.vault_mount_user.name
}

resource "vault_auth_backend" "vault_aws_auth" {
  type = "aws"
}

resource "vault_aws_auth_backend_client" "vault_aws_client" {
  backend    = vault_auth_backend.vault_aws_auth.path
  access_key = aws_iam_access_key.vault_mount_user.id
  secret_key = aws_iam_access_key.vault_mount_user.secret
}

resource "vault_aws_auth_backend_role" "vault_ec2_auth_role" {
  backend        = vault_auth_backend.vault_aws_auth.path
  role           = "f5-device-role"
  auth_type      = "ec2"
  bound_ami_ids  = var.vault_bound_ami_ids
  token_ttl      = 60
  token_max_ttl  = 120
  token_policies = ["cert-policy"]
}

