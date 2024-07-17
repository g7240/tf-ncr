# Open Tofu AWS ncr Example

This repository provides a real-world example of using Open Tofu to deploy a basic infrastructure setup on AWS, including an EC2 instance running an ncr service and an S3 bucket.

## Prerequisites

- [Open Tofu](https://opentofu.org/docs) installed
- AWS CLI configured with your credentials
- A VPC ID where the security group will be created
- An AMI ID for the EC2 instance
- ncr service binary uploaded to an S3 bucket
- ZenCode smart contracts to be stored in an S3 bucket (ask andrea)

## Getting Started

1. **Clone the repository**

   ```sh
   git clone https://github.com/ForkbombEu/tf-ncr.git
   cd tf-ncr
   
2. **cheate ssh key to connect to the ec2 instance**
   ```sh
   ssh-keygen -t rsa -b 2048 -C "noOwnerName" -f ./testRsaKey

3. **Deploy infrastructure on aws**
   ```sh
   cd openTofuCode/
   tofu init
   tofu apply
   ```
   
## Functionalities
Ater some minutes, once infrustructure is fully deployed, you can:

1. **Connect via ssh as admin**
   
   Navigate to the folder tf-ncr/ and use ssh
    ```sh
    cd ..
    ssh -i ./testRsaKey admin@assignedIP
    ```

2. **Visualize the ncr service documentation web page via http**

   Write in your browser the url http://assignedIP:8080/docs or http://domainNaim:8080/
Note: you can finde the assignedIP or the domainNaim to witch the IP is associated in 
your aws ec2 instances page
