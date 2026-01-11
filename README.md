# 📘 POC-29: Infrastructure as Code with Terraform (AWS EC2, VPC, S3, CodeBuild)

## 📌 Project Overview

This project demonstrates **Infrastructure as Code (IaC)** using **Terraform** to provision and manage AWS infrastructure in a **reproducible, automated, and version-controlled** manner.

The project provisions:

* A **custom VPC**
* A **public subnet with Internet Gateway**
* An **EC2 instance**
* An **S3 bucket**
* A **remote Terraform backend** using S3
* **CI/CD automation** using AWS CodeBuild
* **Terraform import** for manually created resources

---

## 🎯 Objectives

* Provision AWS infrastructure using Terraform modules
* Use **remote backend** for Terraform state
* Handle **IAM permissions** for local and CI/CD execution
* Automate Terraform via **AWS CodeBuild**
* Import **manually created EC2 instances** into Terraform state
* Follow **real-world DevOps best practices**

---

## 🛠 Tools & Technologies

* Terraform (v1.x)
* AWS EC2
* AWS VPC
* AWS S3
* AWS IAM
* AWS CodeBuild
* AWS CLI
* Git / GitHub or CodeCommit

---

## 📁 Project Structure

```
POC-29/
├── backend.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── buildspec.yml
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

---

## 🔐 Prerequisites

### 1. AWS Account

* Free Tier account is sufficient

### 2. IAM User / Role

Required permissions:

* EC2
* VPC
* S3
* IAM
* DynamoDB (optional, for locking)
* CodeBuild

> ⚠️ For learning/demo purposes, `AdministratorAccess` can be used.

### 3. Installed Tools

```bash
terraform -version
aws --version
```

---

## 🗂️ Terraform Backend Setup (One-Time)

Terraform **does NOT create its own backend**.
The S3 bucket must exist **before** `terraform init`.

### Create S3 backend bucket

```bash
aws s3api create-bucket \
  --bucket terraform-state-974086408537-poc29-ap-south-1 \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1
```

### Enable versioning (recommended)

```bash
aws s3api put-bucket-versioning \
  --bucket terraform-state-974086408537-poc29-ap-south-1 \
  --versioning-configuration Status=Enabled
```

---

## 📄 backend.tf

```hcl
terraform {
  backend "s3" {
    bucket  = "terraform-state-974086408537-poc29-ap-south-1"
    key     = "project29/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
```

---

## 🚀 Terraform Execution (Local)

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

### Outputs

* VPC ID
* EC2 Public IP
* S3 Bucket Name

---

### ❌ Backend AccessDenied

```
AccessDenied: s3:ListBucket
```

✅ **Fix**: Ensure IAM user / CodeBuild role has:

* `s3:ListBucket`
* `s3:GetObject`
* `s3:PutObject`

---

## 🤖 CI/CD with AWS CodeBuild

### buildspec.yml

```yaml
version: 0.2

phases:
  install:
    commands:
      - yum install -y unzip
      - curl -O https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
      - unzip terraform_1.6.6_linux_amd64.zip
      - mv terraform /usr/local/bin/
      - terraform --version

  pre_build:
    commands:
      - terraform init

  build:
    commands:
      - terraform plan
      - terraform apply -auto-approve
```

---

## 🔐 CodeBuild IAM Permissions (IMPORTANT)

The CodeBuild **service role** must have access to the backend S3 bucket.

Minimum required:

* `s3:ListBucket`
* `s3:GetObject`
* `s3:PutObject`

---

## 🧠 Key Terraform Concepts Demonstrated

* Modular Terraform design
* Remote state management
* IAM troubleshooting
* Terraform import
* State vs real infrastructure
* CI/CD automation
* Free Tier cost awareness

---
## 📌 Author

**Jyothiprakash**
AWS DevOps Engineer
