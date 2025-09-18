# SQS Module Main Configuration
# This file defines the main resources for the SQS module

# Dead Letter Queue
resource "aws_sqs_queue" "dlq" {
  name = "${var.project_name}-${var.environment}-dlq"

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-dlq"
    Environment = var.environment
    Project     = var.project_name
  })
}

# Main Queue
resource "aws_sqs_queue" "main" {
  name                       = "${var.project_name}-${var.environment}-queue"
  visibility_timeout_seconds = 300
  message_retention_seconds  = 1209600

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-queue"
    Environment = var.environment
    Project     = var.project_name
  })
}
