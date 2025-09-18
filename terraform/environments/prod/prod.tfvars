# Production Environment Variables
# This file contains the variable values for the production environment

# AWS Configuration
aws_region = "ap-northeast-1"
environment = "prod"
project_name = "slack-ai-bot"

# Lambda Configuration
lambda_memory_size = 1024
lambda_timeout = 120

# DynamoDB Configuration
dynamodb_billing_mode = "PAY_PER_REQUEST"

# API Gateway Configuration
api_gateway_stage_name = "prod"

# Monitoring Configuration
enable_detailed_monitoring = true

# Logging Configuration
log_retention_days = 30
