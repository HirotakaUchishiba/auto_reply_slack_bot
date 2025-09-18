# Terraform Configuration
# This file defines the Terraform version and provider requirements

terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider configuration
provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Project     = "slack-ai-bot"
      ManagedBy   = "terraform"
      CreatedBy   = "github-actions"
    }
  }
}
