"""
Shared test fixtures and configuration for the Slack AI Assistant Bot test suite.
"""
import os
import pytest
from moto import mock_aws
import boto3
from unittest.mock import Mock, patch

# Set test environment variables
os.environ["AWS_DEFAULT_REGION"] = "ap-northeast-1"
os.environ["AWS_ACCESS_KEY_ID"] = "testing"
os.environ["AWS_SECRET_ACCESS_KEY"] = "testing"
os.environ["AWS_SECURITY_TOKEN"] = "testing"
os.environ["AWS_SESSION_TOKEN"] = "testing"


@pytest.fixture
def mock_dynamodb_client():
    """Mock DynamoDB client for unit tests."""
    with mock_aws():
        client = boto3.client('dynamodb', region_name='ap-northeast-1')
        yield client


@pytest.fixture
def mock_sqs_client():
    """Mock SQS client for unit tests."""
    with mock_aws():
        client = boto3.client('sqs', region_name='ap-northeast-1')
        yield client


@pytest.fixture
def mock_secrets_manager_client():
    """Mock Secrets Manager client for unit tests."""
    with mock_aws():
        client = boto3.client('secretsmanager', region_name='ap-northeast-1')
        yield client


@pytest.fixture
def mock_openai_client():
    """Mock OpenAI client for unit tests."""
    mock_client = Mock()
    mock_response = Mock()
    mock_response.choices = [Mock()]
    mock_response.choices[0].message = Mock()
    mock_response.choices[0].message.content = "Mocked AI response"
    mock_client.chat.completions.create.return_value = mock_response
    return mock_client


@pytest.fixture
def sample_slack_payload():
    """Sample Slack interaction payload for testing."""
    return {
        "type": "block_actions",
        "user": {
            "id": "U1234567890",
            "username": "testuser",
            "name": "Test User"
        },
        "api_app_id": "A1234567890",
        "token": "test_token",
        "container": {
            "type": "message",
            "message_ts": "1234567890.123456"
        },
        "trigger_id": "1234567890.1234567890.abcdef1234567890abcdef1234567890",
        "team": {
            "id": "T1234567890",
            "domain": "testworkspace"
        },
        "channel": {
            "id": "C1234567890",
            "name": "test-channel"
        },
        "response_url": (
            "https://hooks.slack.com/actions/T1234567890/1234567890/"
            "abcdef1234567890"
        ),
        "actions": [
            {
                "action_id": "test_action",
                "block_id": "test_block",
                "value": "test_value",
                "type": "button",
                "action_ts": "1234567890.123456"
            }
        ]
    }


@pytest.fixture
def sample_conversation_data():
    """Sample conversation data for testing."""
    return {
        "user_id": "U1234567890",
        "conversation_id": "conv_1234567890",
        "message": "Test message for AI processing",
        "timestamp": "2024-01-01T00:00:00Z",
        "context": {
            "channel_id": "C1234567890",
            "thread_ts": "1234567890.123456"
        }
    }


@pytest.fixture
def mock_aws_environment():
    """Mock AWS environment for testing."""
    with patch.dict(os.environ, {
        "AWS_DEFAULT_REGION": "ap-northeast-1",
        "AWS_ACCESS_KEY_ID": "testing",
        "AWS_SECRET_ACCESS_KEY": "testing",
        "AWS_SECURITY_TOKEN": "testing",
        "AWS_SESSION_TOKEN": "testing"
    }):
        yield


@pytest.fixture
def mock_dynamodb_table():
    """Create a mock DynamoDB table for testing."""
    with mock_aws():
        dynamodb = boto3.resource('dynamodb', region_name='ap-northeast-1')
        table = dynamodb.create_table(
            TableName='SlackAiBotTable',
            KeySchema=[
                {'AttributeName': 'PK', 'KeyType': 'HASH'},
                {'AttributeName': 'SK', 'KeyType': 'RANGE'}
            ],
            AttributeDefinitions=[
                {'AttributeName': 'PK', 'AttributeType': 'S'},
                {'AttributeName': 'SK', 'AttributeType': 'S'}
            ],
            BillingMode='PAY_PER_REQUEST'
        )
        yield table


@pytest.fixture
def mock_sqs_queue():
    """Create a mock SQS queue for testing."""
    with mock_aws():
        sqs = boto3.client('sqs', region_name='ap-northeast-1')
        queue = sqs.create_queue(QueueName='test-queue')
        yield queue


@pytest.fixture(autouse=True)
def setup_test_environment():
    """Automatically setup test environment for all tests."""
    # This fixture runs automatically for all tests
    with patch.dict(os.environ, {
        "ENVIRONMENT": "test",
        "LOG_LEVEL": "DEBUG"
    }):
        yield
