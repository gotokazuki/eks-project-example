data "aws_eks_cluster_auth" "this" {
  name = "${local.prefix}-${local.eks_cluster_name}"
}

data "aws_route53_zone" "this" {
  name = local.domain
}
