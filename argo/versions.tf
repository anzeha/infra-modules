terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.17.0"
    }
    null = {
      source = "hashicorp/null"
    }
    htpasswd = {
      version = "~> 1.2.1"
      source  = "loafoe/htpasswd"
    }
  }
}