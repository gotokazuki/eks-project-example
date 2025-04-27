module "network" {
  source = "git@github.com:gotokazuki/terraform-aws-network.git?ref=v1.1.0"

  prefix                       = local.prefix
  ipv4_cidr                    = local.ipv4_cidr
  ipv4_cidr_newbits            = local.ipv4_cidr_newbits
  subnets_number               = local.subnets_number
  create_private_subnets       = true
  add_eks_tags_to_subnets      = true
  create_dynamodb_vpc_endpoint = true
}

module "eks" {
  source = "git@github.com:gotokazuki/terraform-aws-eks.git?ref=v1.0.1"

  prefix                                          = local.prefix
  eks_cluster_name                                = local.eks_cluster_name
  eks_cluster_version                             = local.eks_cluster_version
  eks_bootstrap_cluster_creator_admin_permissions = local.eks_bootstrap_cluster_creator_admin_permissions
  eks_enabled_cluster_log_types                   = local.eks_enabled_cluster_log_types
  eks_logs_retention_in_days                      = local.eks_logs_retention_in_days
  eks_access_entries                              = local.eks_access_entries

  vpc_id             = module.network.vpc_id
  vpc_cidr_block     = module.network.vpc_cidr_block
  private_subnet_ids = module.network.private_subnet_ids
}

module "eks_pod_identity" {
  for_each = local.pod_identities

  source = "../modules/eks_pod_identity"

  prefix               = local.prefix
  eks_cluster_name     = module.eks.cluster_name
  namespace            = each.value.namespace
  service_account_name = each.value.service_account_name
  policy_arns          = each.value.policy_arns
}

module "acm" {
  source = "../modules/acm"

  services       = local.services
  domain         = local.domain
  hosted_zone_id = data.aws_route53_zone.this.zone_id
}

module "ddb" {
  source = "../modules/ddb"

  table_name    = "${local.prefix}-todo"
  hash_key      = "id"
  hash_key_type = "S"
}

module "r53" {
  count = local.create_r53 ? 1 : 0

  source = "../modules/r53"

  services       = local.services
  domain         = local.domain
  hosted_zone_id = data.aws_route53_zone.this.zone_id
}
