# Secrets Manager Module Outputs
# This file defines the output values for the Secrets Manager module

output "slack_bot_token_secret_arn" {
  description = "ARN of the Slack Bot Token secret"
  value       = aws_secretsmanager_secret.slack_bot_token.arn
}

output "slack_bot_token_secret_name" {
  description = "Name of the Slack Bot Token secret"
  value       = aws_secretsmanager_secret.slack_bot_token.name
}

output "openai_api_key_secret_arn" {
  description = "ARN of the OpenAI API Key secret"
  value       = aws_secretsmanager_secret.openai_api_key.arn
}

output "openai_api_key_secret_name" {
  description = "Name of the OpenAI API Key secret"
  value       = aws_secretsmanager_secret.openai_api_key.name
}