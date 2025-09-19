# Secrets Manager Module Main Configuration
# This file defines the main resources for the Secrets Manager module
# Implements secure secret management with encryption and rotation

# Local variables
locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# OpenAI API Key Secret (primary secret for the application)
resource "aws_secretsmanager_secret" "openai_api_key" {
  name                    = "${local.name_prefix}-openai-api-key"
  description             = "OpenAI API Key for ${var.project_name} ${var.environment} environment"
  recovery_window_in_days = 7
  
  # Enable automatic rotation (optional - can be configured later)
  # rotation_lambda_arn = aws_lambda_function.rotation_lambda.arn
  
  tags = merge(var.tags, {
    Name        = "${local.name_prefix}-openai-api-key"
    Environment = var.environment
    Project     = var.project_name
    SecretType  = "api-key"
  })
}

# OpenAI API Key Secret Version (placeholder - actual value should be set manually)
resource "aws_secretsmanager_secret_version" "openai_api_key" {
  secret_id = aws_secretsmanager_secret.openai_api_key.id
  secret_string = jsonencode({
    openai_api_key = "REPLACE_WITH_ACTUAL_OPENAI_API_KEY"
  })
  
  lifecycle {
    ignore_changes = [secret_string]
  }
}

# Slack Bot Token Secret (for Slack integration)
resource "aws_secretsmanager_secret" "slack_bot_token" {
  name                    = "${local.name_prefix}-slack-bot-token"
  description             = "Slack Bot Token for ${var.project_name} ${var.environment} environment"
  recovery_window_in_days = 7

  tags = merge(var.tags, {
    Name        = "${local.name_prefix}-slack-bot-token"
    Environment = var.environment
    Project     = var.project_name
    SecretType  = "bot-token"
  })
}

# Slack Bot Token Secret Version (placeholder - actual value should be set manually)
resource "aws_secretsmanager_secret_version" "slack_bot_token" {
  secret_id = aws_secretsmanager_secret.slack_bot_token.id
  secret_string = jsonencode({
    slack_bot_token = "REPLACE_WITH_ACTUAL_SLACK_BOT_TOKEN"
  })
  
  lifecycle {
    ignore_changes = [secret_string]
  }
}

