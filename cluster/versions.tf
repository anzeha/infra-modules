terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.14.0, <= 7.0.0"
    }
    null = {
      source = "hashicorp/null"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

