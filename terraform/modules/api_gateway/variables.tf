# API Gateway Module Variables
# This file defines the input variables for the API Gateway module

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
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
