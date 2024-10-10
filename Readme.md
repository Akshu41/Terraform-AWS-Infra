# Terraform AWS Infrastructure

This project sets up an AWS infrastructure using Terraform to deploy a high-availability application architecture with the following components:

- VPC with public, app, and data subnets across multiple availability zones
- Application Load Balancer (ALB) forwarding traffic to EC2 instances running Nginx
- Aurora MySQL database cluster
- Security Groups to secure the environment

## Prerequisites

Before running this project, ensure you have the following:

- AWS CLI configured with your credentials.
- Terraform installed on your local machine.

## Architecture Overview

This Terraform code deploys the following AWS resources:

- **VPC**: A virtual private cloud with a CIDR block of `10.0.0.0/16`.
- **Subnets**: Three public subnets for the ALB and three app subnets for EC2 instances running Nginx. Additionally, three data subnets are created for the Aurora database cluster.
- **Application Load Balancer (ALB)**: The ALB forwards HTTP traffic on port 80 to a target group containing the EC2 instances running Nginx.
- **EC2 Instances**: Three EC2 instances (Nginx) running in different availability zones to ensure high availability.
- **Aurora MySQL**: A highly available MySQL database cluster with three instances across different subnets.
- **Security Groups**: Security groups are defined to allow traffic between the ALB, EC2 instances, and the Aurora cluster, while restricting unnecessary access.

## Resource Breakdown

### 1. VPC and Subnets
The VPC and subnets are configured to support a multi-tier architecture:

- **VPC**: `10.0.0.0/16`
- **Public Subnets**: `10.0.1.0/24`, `10.0.2.0/24`, `10.0.3.0/24` (used by ALB)
- **App Subnets**: `10.0.4.0/24`, `10.0.5.0/24`, `10.0.6.0/24` (used by EC2 instances)
- **Data Subnets**: `10.0.7.0/24`, `10.0.8.0/24`, `10.0.9.0/24` (used by Aurora database)

### 2. Application Load Balancer (ALB)
- **ALB Name**: `app-lb`
- **Listener on Port 80**: Forwards HTTP traffic to the EC2 instances running Nginx.
- **Target Group**: `app-tg`, configured to route traffic to Nginx instances.

### 3. EC2 Instances (Nginx)
- **AMI**: Replace `ami-054a53dca63de757b` with the appropriate Nginx AMI for your region.
- **Instance Type**: `t2.micro`
- **Nginx Setup**: Nginx is automatically installed and configured on startup using `user_data`.

### 4. Aurora MySQL Cluster
- **Cluster Identifier**: `aurora-cluster-example`
- **Engine**: `aurora-mysql`
- **Engine Version**: `5.7.mysql_aurora.2.11.5`
- **Instances**: 3 instances of type `db.t3.small`

### 5. Security Groups
- **ALB Security Group**: Allows inbound HTTP traffic on port 80.
- **EC2 Security Group**: Allows inbound traffic on port 80 from the ALB.
- **Aurora Security Group**: Allows inbound traffic on port 3306 from within the VPC.

## Variables

This project uses variables for VPC and subnet CIDR blocks. The variables are defined in `variable.tf`:

- **VPC CIDR**: Default is `10.0.0.0/16`
- **Public Subnet CIDRs**: Default values are `10.0.1.0/24`, `10.0.2.0/24`, and `10.0.3.0/24`

You can adjust these values as needed by modifying the `variable.tf` file.

## Outputs

The following outputs are defined:

- **ALB DNS Name**: The DNS name of the Application Load Balancer.
- **Nginx Instance IDs**: The IDs of the EC2 instances running Nginx.
- **VPC ID**: The ID of the created VPC.

## Usage

### 1. Clone this repository:

```bash
git clone https://github.com/Akshu41/Terraform-AWS-Infra.git
cd terraform-aws-infra


### 2. Initialize Terraform:
```bash
terraform init

### 3.Preview the resources that Terraform will create:
```bash
terraform plan