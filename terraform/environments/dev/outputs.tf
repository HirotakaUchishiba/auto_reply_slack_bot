# Development Environment Outputs
# This file defines the output values for the development environment

# API Gateway outputs
output "api_gateway_url" {
  description = "API Gateway endpoint URL"
  value       = module.api_gateway.api_gateway_url
}

output "api_gateway_id" {
  description = "API Gateway ID"
  value       = module.api_gateway.api_gateway_id
}

# Lambda outputs
output "lambda_function_name" {
  description = "Lambda function name"
  value       = module.lambda.function_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = module.lambda.function_arn
}

# DynamoDB outputs
output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  value       = module.dynamodb.table_arn
}

# SQS outputs
output "sqs_dlq_url" {
  description = "SQS Dead Letter Queue URL"
  value       = module.sqs.dlq_url
}

output "sqs_dlq_arn" {
  description = "SQS Dead Letter Queue ARN"
  value       = module.sqs.dlq_arn
}

# IAM outputs
output "lambda_execution_role_arn" {
  description = "Lambda execution role ARN"
  value       = module.iam.lambda_execution_role_arn
}

# Secrets Manager outputs
output "openai_api_key_secret_arn" {
  description = "OpenAI API key secret ARN"
  value       = module.secrets_manager.openai_api_key_secret_arn
}

# Environment information
output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}
