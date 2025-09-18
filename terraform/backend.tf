# Terraform Backend Configuration
# This file defines the remote state storage for Terraform

terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # S3 backend configuration for remote state storage
  backend "s3" {
    # These values will be provided via backend configuration
    # bucket         = "your-terraform-state-bucket"
    # key            = "slack-ai-bot/terraform.tfstate"
    # region         = "ap-northeast-1"
    # encrypt        = true
    # dynamodb_table = "terraform-state-lock"
  }
}

# AWS Provider configuration
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "slack-ai-bot"
      Environment = var.environment
      ManagedBy   = "terraform"
      CreatedBy   = "github-actions"
    }
  }
}

# Local variables
locals {
  common_tags = {
    Project     = "slack-ai-bot"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
