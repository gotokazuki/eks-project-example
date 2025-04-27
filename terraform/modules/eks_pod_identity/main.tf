resource "aws_iam_role" "this" {
  name = "${var.prefix}-service-account-${var.service_account_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession",
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.policy_arns

  policy_arn = each.key
  role       = aws_iam_role.this.name
}

resource "aws_eks_pod_identity_association" "this" {
  cluster_name    = var.eks_cluster_name
  namespace       = var.namespace
  service_account = var.service_account_name
  role_arn        = aws_iam_role.this.arn
}
