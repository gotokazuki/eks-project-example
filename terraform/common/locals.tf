locals {
  prefix = "goto-common"

  default_tags = {
    owner       = "gotokazuki"
    repository  = "eks-project-example"
    created_by  = "terraform"
    environment = "common"
  }
}
