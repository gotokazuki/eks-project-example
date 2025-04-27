module "ecr" {
  for_each = toset([
    "${local.prefix}-todo",
  ])

  source = "git@github.com:gotokazuki/terraform-aws-ecr.git?ref=v1.0.0"

  repository_name              = each.key
  image_tag_mutability         = "MUTABLE"
  force_delete                 = true
  principals_for_cross_account = []
}
