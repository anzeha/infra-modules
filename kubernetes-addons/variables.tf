variable "project_id" {
  type = string
}
variable "env" {
  type        = string
  description = "Environment name"
  validation {
    condition     = var.env == "dev" || var.env == "prod" || var.env == "staging"
    error_message = "Environment variable has to be one of 'env', 'staging' or prod"
  }
}
variable "deploy_nginx" {
  type    = bool
  default = true
}
variable "cluster_name" {
  type = string
  default = "wtf-wtf-wtf"
}

variable "region" {
  type    = string
  default = "europe-west4"
}

variable "create_app_namespace" {
  type    = bool
  default = false
}

variable "app_namespace" {
  type    = string
  default = "app-namespace"
}