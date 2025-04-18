terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    # local = {
    #   source = "hashicorp/local"
    # }
    htpasswd = {
      version = "~> 1.2.1"
      source  = "loafoe/htpasswd"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 6.14.0, < 7.0.0"
    }
  }
}
