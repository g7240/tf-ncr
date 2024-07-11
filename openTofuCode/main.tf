provider "aws" {
  region = "eu-west-3"
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-fjjdxq3o90p"
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
  ami           = "ami-0314c062c813a4aa0" # Choose AMI that fits your needs
  instance_type = "t2.micro"
  security_groups = [aws_security_group.ncr_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo '<html><body><h1>NCR Service</h1></body></html>' > /var/www/html/index.html
              EOF

  tags = {
    Name = "NCR Instance"
  }
}

