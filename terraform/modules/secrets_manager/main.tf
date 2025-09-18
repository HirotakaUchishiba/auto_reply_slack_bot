# Secrets Manager Module Main Configuration
# This file defines the main resources for the Secrets Manager module

# Slack Bot Token Secret
resource "aws_secretsmanager_secret" "slack_bot_token" {
  name                    = "${var.project_name}-${var.environment}-slack-bot-token"
  description             = "Slack Bot Token for ${var.project_name} ${var.environment} environment"
  recovery_window_in_days = 7

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-slack-bot-token"
    Environment = var.environment
    Project     = var.project_name
  })
}

# Slack Bot Token Secret Version
resource "aws_secretsmanager_secret_version" "slack_bot_token" {
  secret_id = aws_secretsmanager_secret.slack_bot_token.id
  secret_string = jsonencode({
    slack_bot_token = "xoxb-your-slack-bot-token-here"
  })
}

# OpenAI API Key Secret
resource "aws_secretsmanager_secret" "openai_api_key" {
  name                    = "${var.project_name}-${var.environment}-openai-api-key"
  description             = "OpenAI API Key for ${var.project_name} ${var.environment} environment"
  recovery_window_in_days = 7

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-openai-api-key"
    Environment = var.environment
    Project     = var.project_name
  })
}

# OpenAI API Key Secret Version
resource "aws_secretsmanager_secret_version" "openai_api_key" {
  secret_id = aws_secretsmanager_secret.openai_api_key.id
  secret_string = jsonencode({
    openai_api_key = "sk-your-openai-api-key-here"
  })
}

