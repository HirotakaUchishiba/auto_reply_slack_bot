# Lambda Module Main Configuration
# This file defines the main resources for the Lambda module

# Data source for current AWS region
data "aws_region" "current" {}

# Lambda function
resource "aws_lambda_function" "main" {
  filename         = "lambda_function.zip"
  function_name    = "${var.project_name}-${var.environment}-slack-bot"
  role            = var.lambda_execution_role_arn
  handler         = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime         = "python3.9"
  timeout         = 30

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = var.dynamodb_table_name
      SQS_DLQ_URL        = var.sqs_dlq_url
      ENVIRONMENT        = var.environment
    }
  }

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-slack-bot"
    Environment = var.environment
    Project     = var.project_name
  })
}

# Create a zip file for the Lambda function
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "lambda_function.zip"
  source {
    content = <<EOF
import json
import boto3
import os

def lambda_handler(event, context):
    """
    Lambda function handler for Slack bot
    """
    print(f"Received event: {json.dumps(event)}")
    
    # Initialize AWS clients
    dynamodb = boto3.resource('dynamodb')
    sqs = boto3.client('sqs')
    
    # Get environment variables
    table_name = os.environ.get('DYNAMODB_TABLE_NAME')
    dlq_url = os.environ.get('SQS_DLQ_URL')
    
    try:
        # Process the event
        response = {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Slack bot processed successfully',
                'environment': os.environ.get('ENVIRONMENT', 'unknown')
            })
        }
        
        return response
        
    except Exception as e:
        print(f"Error processing event: {str(e)}")
        
        # Send to DLQ if available
        if dlq_url:
            try:
                sqs.send_message(
                    QueueUrl=dlq_url,
                    MessageBody=json.dumps({
                        'error': str(e),
                        'event': event
                    })
                )
            except Exception as dlq_error:
                print(f"Failed to send to DLQ: {str(dlq_error)}")
        
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': 'Internal server error'
            })
        }
EOF
    filename = "lambda_function.py"
  }
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.main.function_name}"
  retention_in_days = 14

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-lambda-logs"
    Environment = var.environment
    Project     = var.project_name
  })
}

