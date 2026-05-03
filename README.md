# Terraform Docker Nginx Demo

![Pipeline Status](https://gitlab.com/Ikayou/infrastructure/badges/main/pipeline.svg)

## Overview
This project provisions an Nginx container using Terraform and Docker provider.

## Architecture
Terraform → Docker Provider → Nginx Container

## Features
- Infrastructure as Code with Terraform
- Docker container provisioning
- Modular structure (reusable modules)

## How to run
```bash
terraform init
terraform apply