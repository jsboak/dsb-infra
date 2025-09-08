terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
  }

  backend "s3" {
    bucket         = "perf-lab-tfstate-123456789012"
    key            = "perf-lab/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "perf-lab-tflock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Team        = "perf-eng"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
