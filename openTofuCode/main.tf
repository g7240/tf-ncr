provider "aws" {
  region = var.region
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

# Create a security group to allow HTTP access
resource "aws_security_group" "ncr_sg" {
  name        = "ncr_sg"
  description = "Allow HTTP traffic"
  
  ingress {
    from_port   = 80
    to_port     = 80
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
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo '<html><body><h1>Accessible web page</h1></body></html>' > /var/www/html/index.html
              EOF

  tags = {
    Name = "NCR Instance"
  }
}

