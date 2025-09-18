# Lambda Module Variables
# This file defines the input variables for the Lambda module

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution role"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "sqs_dlq_url" {
  description = "URL of the SQS Dead Letter Queue"
  type        = string
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
