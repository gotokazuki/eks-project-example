variable "hosted_zone_id" {
  description = "Zone ID to use for the Route53 hosted zone."
  type        = string
}
variable "services" {
  type = set(string)
}
variable "domain" {
  type = string
}
