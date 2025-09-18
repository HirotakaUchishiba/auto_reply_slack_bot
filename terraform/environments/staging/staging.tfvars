# Staging Environment Variables
# This file contains the variable values for the staging environment

# AWS Configuration
aws_region = "ap-northeast-1"
environment = "staging"
project_name = "slack-ai-bot"

# Lambda Configuration
lambda_memory_size = 512
lambda_timeout = 60

# DynamoDB Configuration
dynamodb_billing_mode = "PAY_PER_REQUEST"

# API Gateway Configuration
api_gateway_stage_name = "staging"

# Monitoring Configuration
enable_detailed_monitoring = true

# Logging Configuration
log_retention_days = 14
