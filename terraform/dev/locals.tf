locals {
  prefix = "goto-dev"

  create_r53 = true

  domain         = "ccswebdragon.com"

  ipv4_cidr         = "10.0.0.0/16"
  ipv4_cidr_newbits = 3
  subnets_number    = 2

  eks_cluster_name    = "eks-project"
  eks_cluster_version = "1.32"
  eks_enabled_cluster_log_types = [
    "api",
    "authenticator",
    "controllerManager",
    "scheduler",
    "audit",
  ]
  eks_bootstrap_cluster_creator_admin_permissions = true
  eks_logs_retention_in_days                      = 30
  eks_access_entries                              = {}

  services = toset([
    "todo",
  ])
  services_index = [for k, v in local.services : k]

  pod_identities = {
    todo = {
      namespace            = "default"
      service_account_name = "todo-sa"
      policy_arns = [
        "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
      ]
    }
  }

  default_tags = {
    owner       = "gotokazuki"
    repository  = "eks-project-example"
    created_by  = "terraform"
    environment = "dev"
  }
}