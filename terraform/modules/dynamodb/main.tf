# DynamoDB Module Main Configuration
# This file defines the main resources for the DynamoDB module

# DynamoDB Table for conversation history
resource "aws_dynamodb_table" "conversation_history" {
  name           = "${var.project_name}-${var.environment}-conversation-history"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "conversation_id"
  range_key      = "timestamp"

  attribute {
    name = "conversation_id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  global_secondary_index {
    name               = "user-id-index"
    hash_key           = "user_id"
    projection_type    = "ALL"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-conversation-history"
    Environment = var.environment
    Project     = var.project_name
  })
}
