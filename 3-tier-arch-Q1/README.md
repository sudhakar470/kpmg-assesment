# Pre-requuisites
1. Terraform 
2. AWS CLI
3. aws configure and provide credentials 

# Getting Started
In order to get this repo to work correctly, please complete the following steps before initializing Terraform
1. Add an environment variable or console variable called "AWS_PROFILE" and assign the value of "saml" or "default"

# Initialize and configure DEV
terraform init -backend-config="backends/dev-backend.tfvars" -reconfigure\
terraform plan var-file=variables/dev.tfvars
terraform apply var-file=variables/dev.tfvars

if you don't want to create entire infrastructure and in need of only 1 specific resource creation you can execute the below command

terraform plan -var-file=variables/dev.tfvars -target aws_dynamodb_table.dynamodb

terraform apply -var-file=variables/dev.tfvars -target aws_dynamodb_table.dynamodb

This command will create only dynamo DB table.
