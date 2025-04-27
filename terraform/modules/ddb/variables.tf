variable "table_name" {}
variable "billing_mode" {
  default = "PAY_PER_REQUEST"
}
variable "hash_key" {}
variable "hash_key_type" {
  default = "S"
}
variable "range_key" {
  default = null
}
variable "range_key_type" {
  default = "S"
}

variable "ttl_enabled" {
  default = false
}
variable "ttl_attribute_name" {
  default = ""
}

variable "global_secondary_indexes" {
  default = []
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = string
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
}
