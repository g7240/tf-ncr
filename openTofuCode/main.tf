provider "aws" {
  region = var.region
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

# Create a security group to allow HTTP access on port 8080 and outbound traffic on ports 80 and 443
resource "aws_security_group" "ncr_sg" {
  name        = "ncr_sg"
  description = "Allow HTTP traffic on port 8080 and outgoing traffic on port 80 and 443"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance to run the NCR service
resource "aws_instance" "ncr_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.ncr_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              # Update the package repository
              apt-get update -y
              # Install required packages
              apt-get install -y wget git
              # Create the directory for local binaries if it doesn't exist
              mkdir -p ~/.local/bin
              # Download the binary
              wget https://github.com/forkbombeu/ncr/releases/latest/download/ncr -O ~/.local/bin/ncr && chmod +x ~/.local/bin/ncr
              # Add ~/.local/bin to PATH
              export PATH=$PATH:~/.local/bin
              # Clone the repository
              git clone https://github.com/forkbombeu/ncr
              # Run the server with the example folder
              ncr -p 8080 -z ./ncr/tests/fixtures --public-directory ./ncr/public &
              EOF

  tags = {
    Name = "NCR Instance"
  }
}

