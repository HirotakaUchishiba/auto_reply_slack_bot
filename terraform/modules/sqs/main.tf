# SQS Module Main Configuration
# This file defines the main resources for the SQS module
# Implements resilient message processing with Dead Letter Queue

# Local variables
locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# Dead Letter Queue (DLQ) for failed message processing
resource "aws_sqs_queue" "dlq" {
  name = "${local.name_prefix}-dlq"
  
  # DLQ specific settings
  message_retention_seconds = 1209600  # 14 days
  visibility_timeout_seconds = 30      # Short timeout for DLQ
  
  # Enable server-side encryption
  kms_master_key_id = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
  
  # Enable content-based deduplication
  content_based_deduplication = true
  
  tags = merge(var.tags, {
    Name        = "${local.name_prefix}-dlq"
    Environment = var.environment
    Project     = var.project_name
    QueueType   = "dead-letter-queue"
  })
}

# Main processing queue with DLQ redrive policy
resource "aws_sqs_queue" "main" {
  name = "${local.name_prefix}-processing-queue"
  
  # Queue settings for async processing
  visibility_timeout_seconds = 300     # 5 minutes (should match Lambda timeout)
  message_retention_seconds  = 1209600 # 14 days
  receive_wait_time_seconds  = 20      # Long polling
  
  # Redrive policy to send failed messages to DLQ
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3  # Retry failed messages 3 times before sending to DLQ
  })
  
  # Enable server-side encryption
  kms_master_key_id = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
  
  # Enable content-based deduplication
  content_based_deduplication = true
  
  tags = merge(var.tags, {
    Name        = "${local.name_prefix}-processing-queue"
    Environment = var.environment
    Project     = var.project_name
    QueueType   = "main-processing-queue"
  })
}
