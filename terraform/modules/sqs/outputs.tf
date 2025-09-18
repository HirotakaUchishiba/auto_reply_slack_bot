# SQS Module Outputs
# This file defines the output values for the SQS module

output "dlq_url" {
  description = "URL of the Dead Letter Queue"
  value       = aws_sqs_queue.dlq.url
}

output "dlq_arn" {
  description = "ARN of the Dead Letter Queue"
  value       = aws_sqs_queue.dlq.arn
}

output "dlq_name" {
  description = "Name of the Dead Letter Queue"
  value       = aws_sqs_queue.dlq.name
}

output "main_queue_url" {
  description = "URL of the main queue"
  value       = aws_sqs_queue.main.url
}

output "main_queue_arn" {
  description = "ARN of the main queue"
  value       = aws_sqs_queue.main.arn
}

output "main_queue_name" {
  description = "Name of the main queue"
  value       = aws_sqs_queue.main.name
}
