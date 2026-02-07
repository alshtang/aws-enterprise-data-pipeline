# AWS Enterprise Data Pipeline

A resilient, scalable, and secure data processing pipeline built on AWS using Infrastructure as Code (Terraform).

## Architecture Overview
This project demonstrates a production-grade networking foundation in the **eu-central-1 (Frankfurt)** region, following best practices for security and isolation:

* **Virtual Private Cloud (VPC):** A dedicated isolated network environment.
* **Public Subnet:** Hosts the Internet Gateway and NAT Gateway.
* **Private Subnet:** Isolated environment for data processing logic, preventing direct exposure to the public internet.
* **NAT Gateway:** Enables secure outbound communication for resources in the private subnet (e.g., for software updates or API calls).

## Tech Stack
* **Cloud:** AWS
* **Infrastructure as Code:** Terraform
* **Processing:** Python (Coming soon)
* **Containerization:** Docker (Coming soon)

## Security & SRE Focus
* **Network Isolation:** All data processing occurs in private subnets.
* **Compliance:** Designed with GDPR considerations by keeping data within the Frankfurt region.
* **Automation:** 100% of the infrastructure is managed via Terraform, ensuring consistency and preventing "configuration drift".

## How to Run
1. Initialize Terraform: `terraform init`
2. Preview changes: `terraform plan`
3. Deploy: `terraform apply`