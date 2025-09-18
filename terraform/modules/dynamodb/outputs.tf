# DynamoDB Module Outputs
# This file defines the output values for the DynamoDB module

output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.conversation_history.name
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.conversation_history.arn
}

output "table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.conversation_history.id
}
