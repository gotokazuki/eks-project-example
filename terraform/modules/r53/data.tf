data "aws_lb" "this" {
  tags = {
    "ingress.eks.amazonaws.com/stack" = "apps"
  }
}
