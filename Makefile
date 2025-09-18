# Slack AI Assistant Bot - Development Makefile
# This Makefile provides standardized commands for common development tasks

.PHONY: help install lint test-unit test-integration test-e2e clean format check-all

# Default target
help:
	@echo "Available commands:"
	@echo "  install          - Install dependencies"
	@echo "  lint             - Run linting (flake8, mypy)"
	@echo "  test-unit        - Run unit tests"
	@echo "  test-integration - Run integration tests"
	@echo "  test-e2e         - Run end-to-end tests"
	@echo "  format           - Format code with black"
	@echo "  check-all        - Run all checks (lint + test-unit)"
	@echo "  clean            - Clean up temporary files"

# Install dependencies
install:
	pip install -r requirements.txt
	pip install -r requirements-dev.txt

# Linting
lint:
	flake8 src/ tests/
	mypy src/

# Unit tests
test-unit:
	pytest tests/unit/ -v

# Integration tests
test-integration:
	pytest tests/integration/ -v

# End-to-end tests
test-e2e:
	pytest tests/e2e/ -v

# Code formatting
format:
	black src/ tests/

# Run all checks
check-all: lint test-unit

# Clean up
clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
