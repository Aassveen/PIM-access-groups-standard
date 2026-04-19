terraform {
  required_version = ">= 1.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.50"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13"
    }
  }
}