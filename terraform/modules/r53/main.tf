resource "aws_route53_record" "this" {
  for_each = var.services

  zone_id = var.hosted_zone_id
  name    = "${each.key}.${var.domain}"
  type    = "A"

  alias {
    name                   = data.aws_lb.this.dns_name
    zone_id                = data.aws_lb.this.zone_id
    evaluate_target_health = true
  }
}
