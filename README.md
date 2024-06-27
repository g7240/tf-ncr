# Open Tofu AWS ncr Example

This repository provides a real-world example of using Open Tofu to deploy a basic infrastructure setup on AWS, including an EC2 instance running an ncr service and an S3 bucket.

## Prerequisites

- [Open Tofu](https://www.terraform.io/downloads.html) installed
- AWS CLI configured with your credentials
- A VPC ID where the security group will be created
- An AMI ID for the EC2 instance
- ncr service binary uploaded to an S3 bucket

## Getting Started

1. **Clone the repository**

   ```sh
   git clone https://github.com/ForkbombEu/tf-ncr.git
   cd tf-ncr

