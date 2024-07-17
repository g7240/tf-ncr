provider "aws" {
  region = var.region
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

# Create a security group to allow HTTP access on port 8080, outbound traffic on ports 80 and 443, and SSH access on port 22
resource "aws_security_group" "ncr_sg" {
  name        = "ncr_sg"
  description = "Allow HTTP traffic on port 8080, SSH access on port 22"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

# Define the key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = file(var.public_key_path)
}

# Create an EC2 instance to run the NCR service
resource "aws_instance" "ncr_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.ncr_sg.name]
  key_name      = aws_key_pair.deployer.key_name

  user_data = base64encode(file(var.user_data))

  tags = {
    Name = "NCR Instance"
  }
}


