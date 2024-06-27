# Project Requirements

You are tasked with creating an example project that demonstrates the use of Open Tofu and OpenTofu for infrastructure management. This project should include setting up an AWS S3 bucket and an EC2 instance running an NCR service.

## Objectives

  1. Use Open Tofu and OpenTofu to define and deploy infrastructure.
  1. Ensure the setup includes an AWS S3 bucket and an EC2 instance running an NCR service.
  1.  Configure the EC2 instance to allow public access to the NCR service's REST API.
  1.  Provide clear and detailed documentation for the setup process.

## Deliverables

 1. Repository Structure:
   - `main.tf`: Contains the main Open Tofu configuration.
   - `variables.tf`: Contains the variable definitions.
   - `outputs.tf`: Contains the output definitions.
   - `user-data.sh`: Script to configure the EC2 instance.
   - `README.md`: Documentation on how to use the project.
   - `.gitignore`: To ignore unnecessary files.
   - `user-stories.md`: Document outlining the user stories.
 1.  Code Requirements:
   - Use the AWS provider in Open Tofu.
   - Create a private S3 bucket.
   - Create an EC2 instance in a specified VPC.
   - Create a security group allowing SSH access and public access to the NCR service port.
   - Configure the EC2 instance to run the NCR service, with contracts stored in the S3 bucket.
   - Parameterize variables for flexibility (e.g., region, bucket name, AMI ID).

 1. Documentation:
   - Instructions for setting up and using the project in README.md.
   - User stories in user-stories.md.
