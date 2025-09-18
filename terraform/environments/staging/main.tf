# Staging Environment Configuration
# This file defines the infrastructure for the staging environment

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
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "slack-ai-bot"
      Environment = "staging"
      ManagedBy   = "terraform"
    }
  }
}

# Local variables
locals {
  environment = "staging"
  common_tags = {
    Project     = "slack-ai-bot"
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# IAM Module
module "iam" {
  source = "../../modules/iam"
  
  environment = local.environment
  project_name = "slack-ai-bot"
  
  tags = local.common_tags
}

# Secrets Manager Module
module "secrets_manager" {
  source = "../../modules/secrets_manager"
  
  environment = local.environment
  project_name = "slack-ai-bot"
  
  tags = local.common_tags
}

# SQS Module
module "sqs" {
  source = "../../modules/sqs"
  
  environment = local.environment
  project_name = "slack-ai-bot"
  
  tags = local.common_tags
}

# DynamoDB Module
module "dynamodb" {
  source = "../../modules/dynamodb"
  
  environment = local.environment
  project_name = "slack-ai-bot"
  
  tags = local.common_tags
}

# Lambda Module
module "lambda" {
  source = "../../modules/lambda"
  
  environment = local.environment
  project_name = "slack-ai-bot"
  
  # Dependencies
  lambda_execution_role_arn = module.iam.lambda_execution_role_arn
  dynamodb_table_name = module.dynamodb.table_name
  sqs_dlq_url = module.sqs.dlq_url
  
  tags = local.common_tags
}

# API Gateway Module
module "api_gateway" {
  source = "../../modules/api_gateway"
  
  environment = local.environment
  project_name = "slack-ai-bot"
  
  # Dependencies
  lambda_function_arn = module.lambda.function_arn
  lambda_function_name = module.lambda.function_name
  
  tags = local.common_tags
}
