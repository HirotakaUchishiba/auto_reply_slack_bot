# IAM Module Main Configuration
# This file defines the main resources for the IAM module
# Implements least privilege principle with minimal required permissions

# Local variables
locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# Lambda execution role
resource "aws_iam_role" "lambda_execution_role" {
  name = "${local.name_prefix}-lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Name        = "${local.name_prefix}-lambda-execution-role"
    Environment = var.environment
    Project     = var.project_name
  })
}

# Attach basic Lambda execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Custom policy for DynamoDB access (least privilege)
resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name = "${local.name_prefix}-lambda-dynamodb-policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query"
        ]
        Resource = [
          "arn:aws:dynamodb:${var.aws_region}:*:table/${local.name_prefix}-conversations"
        ]
      }
    ]
  })
}

# Custom policy for SQS access (least privilege)
resource "aws_iam_role_policy" "lambda_sqs_policy" {
  name = "${local.name_prefix}-lambda-sqs-policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage"
        ]
        Resource = [
          "arn:aws:sqs:${var.aws_region}:*:${local.name_prefix}-dlq"
        ]
      }
    ]
  })
}

# Custom policy for Secrets Manager access (least privilege)
resource "aws_iam_role_policy" "lambda_secrets_manager_policy" {
  name = "${local.name_prefix}-lambda-secrets-manager-policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          "arn:aws:secretsmanager:${var.aws_region}:*:secret:${local.name_prefix}-openai-api-key*"
        ]
      }
    ]
  })
}

