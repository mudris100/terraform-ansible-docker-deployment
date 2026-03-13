# Terraform + Ansible Docker Deployment on AWS

This project demonstrates a simple **DevOps deployment workflow** using **Infrastructure as Code and configuration management**.

Infrastructure is provisioned with **Terraform**, and server configuration and application deployment are handled with **Ansible**.

The deployed application runs inside **Docker** on an **Amazon Web Services** EC2 instance.

The project demonstrates a typical DevOps workflow:

```text
Terraform → AWS EC2 → Ansible → Docker → Java Application
```

---

## Architecture

```text
Developer
   │
   │ terraform apply
   ▼
AWS EC2 instance created
   │
   │ ./deploy.sh
   ▼
Ansible connects via SSH
   │
   ▼
Docker installed
   │
   ▼
Docker image pulled from DockerHub
   │
   ▼
Java blog application container started
```

Application becomes accessible via the EC2 public IP.

---

## Project Structure

```text
terraform-ansible-docker-deployment
│
├── ansible.cfg
├── deploy.sh
├── deploy.yml
│
├── main.tf
├── providers.tf
├── security-groups.tf
├── variables.tf
├── terraform.tfvars
│
└── README.md
```

### Terraform files

| File                 | Description                             |
| -------------------- | --------------------------------------- |
| `main.tf`            | Creates AWS EC2 instance                |
| `providers.tf`       | AWS provider configuration              |
| `security-groups.tf` | Security group allowing HTTP/SSH access |
| `variables.tf`       | Input variables                         |
| `terraform.tfvars`   | Variable values                         |

Terraform state is stored remotely using:

* **S3 bucket** (state storage)
* **DynamoDB table** (state locking)

---

### Ansible files

| File          | Description                             |
| ------------- | --------------------------------------- |
| `deploy.yml`  | Installs Docker and deploys application |
| `ansible.cfg` | Ansible configuration                   |
| `deploy.sh`   | Helper script to run deployment         |

The Ansible playbook:

1. Connects to the EC2 instance via SSH
2. Installs Docker
3. Pulls a Docker image from DockerHub
4. Starts the container

---

## Deployment

### 1. Create infrastructure

```bash
terraform init
terraform apply
```

This creates:

* AWS EC2 instance
* security group
* public IP address

---

### 2. Deploy application

Run:

```bash
./deploy.sh
```

The script retrieves the EC2 public IP from Terraform output and runs the Ansible playbook:

```bash
ansible-playbook deploy.yml -i "$(terraform output -raw ubuntu_public_ip),"
```

---

## Application

The container runs a Java Spring Boot blog application.

Docker image:

```text
mudris100/blog-app:1
```

The application is exposed on:

```text
http://EC2_PUBLIC_IP
```

---

## Requirements

Tools required locally:

* **Terraform**
* **Ansible**
* **Docker** (optional for local testing)
* **Amazon Web Services** account
* SSH key for EC2 access

---

## Key DevOps Concepts Demonstrated

This project demonstrates several DevOps practices:

* Infrastructure as Code with Terraform
* Remote Terraform state management (S3 + DynamoDB)
* Automated server configuration with Ansible
* Containerized application deployment with Docker
* Infrastructure → configuration → application workflow

---

## Future Improvements

Possible enhancements:

* CI/CD pipeline using **GitLab CI/CD**
* Terraform modules
* Ansible roles
* Load balancer + multiple EC2 instances
* Kubernetes deployment

---
