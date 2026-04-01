# goit-neo-devops-lesson-db-module

# Universal Terraform RDS Module

This repository provides a reusable Terraform module designed to provision AWS RDS databases in two alternative configurations:

- **Standard MySQL RDS instance** (`use_aurora = false`)
- **Aurora MySQL cluster** (`use_aurora = true`)

The module exposes a unified interface that makes it possible to switch between a traditional RDS setup and an Aurora-based architecture based on the needs of a specific environment or project.

## Key Capabilities

- Supports deployment of both **classic MySQL RDS** and **Aurora MySQL**
- Uses the `use_aurora` variable to control which database architecture is created
- Allows customization of engine version and instance class
- Enables deployment within selected subnets inside a specified VPC
- Designed to be reused as a modular database component across multiple environments

## Example Usage

Below is a sample Terraform configuration demonstrating how to use the module:

```hcl
module "rds" {
  source = "./modules/rds"

  # Name of the project or environment.
  # Commonly used as a prefix for AWS resource names.
  project_name = "example"

  # Set to false to deploy a standard MySQL RDS instance.
  # Set to true to deploy an Aurora MySQL cluster.
  use_aurora = false

  # Database engine type.
  # Typically set to "mysql" for both standard RDS and Aurora MySQL compatibility.
  engine = "mysql"

  # Version of the database engine.
  # Ensure that the specified version is available in your AWS region.
  engine_version = "8.0"

  # Instance size used for the database instance or cluster nodes.
  # Example: db.t3.micro for development or testing environments.
  instance_class = "db.t3.micro"

  # Enables Multi-AZ deployment to improve availability.
  # This option mainly applies to standard RDS instances.
  multi_az = false

  # Identifier of the VPC where the database will be deployed.
  vpc_id = "vpc-xxxx"

  # Subnets used to create the DB subnet group.
  # These should typically be private subnets spread across multiple availability zones.
  subnet_ids = ["subnet-a", "subnet-b"]

  # Username for the database administrator account.
  db_username = "admin"

  # Password for the database administrator account.
  # Avoid storing plain-text passwords in production.
  # Consider using AWS Secrets Manager, SSM Parameter Store, or sensitive Terraform variables instead.
  db_password = "password123"
}
```