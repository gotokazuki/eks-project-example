variable "prefix" {
  type = string
}
variable "service_account_name" {
  type = string
}
variable "policy_arns" {
  type = set(string)
}
variable "eks_cluster_name" {
  type = string
}
variable "namespace" {
  type    = string
  default = "default"
}
