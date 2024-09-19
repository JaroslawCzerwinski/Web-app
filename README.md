# Web App


This repository contains the solution for a task aimed to deploying a simple static application in AWS using an EC2 instance. The application is hosted in a Docker container utilizing the nginx image. The deployment process is orchestrated using GitHub Actions, triggered by every push to the `main` branch.

### Task Requirements

1. The solution must utilize AWS cloud services.
2. The code repository must be hosted on GitHub.
3. Deployment of the infrastructure and application must use Terraform.
4. Access to the application must be restricted to the NLB.
5. SSH access to VM is permitted only from a specific IP address.

### Pipeline Overview
The pipeline consists of four main steps, which can be found in the `.github/workflows/ci-cd.yml` file:

1. **Image Build**: Build an image using Dockerfile, test it and push it out to AWS ECR.

2. **Infrastructure Creation**: Deploy the necessary infrastructure to host the application (VPC, subnets, routing tables, security groups, EC2, NLB, etc.).
3. **Application Deployment**: Deploy the container application using a self-hosted GitHub  runner.
4. **Health Check**: Verify that the web app returns HTTP 200 status code using the NLB endpoint.

After successfully completing the prerequisite steps, the pipeline will automatically update the application infrastructure and deploy a new version whenever changes are made.


### Prerequisites
1. In the `Infra/02-Web-app-infra/terraform.tfvars` file, set the IP address from which SSH access to the VM will be allowed.
2. Place the public key in `Infra/02-Web-app-infra/ssh_keys/web_app_key.pub`, which will be added to the VM for ssh access.
3. Manually execute the Terraform code in `Infra/01-Terraform-state` and migrate the state to the backend (detailed commands below).
4. The GitHub Actions pipeline requires the following secrets to be set:
   - `AWS_ACCOUNT_ID`
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `SELF_HOSTED_RUNNER_TOKEN` (how to get a token information below)
5. The GitHub Actions pipeline requires the following variable to be set:
   - `AWS_ECR_URI` (repository address, e.g., `<account-id>.dkr.ecr.<region>.amazonaws.com/<repo-name>`;  
   this can be obtained from Terraform `output` in `Infra/01-Terraform-state`).

### How to Execute Step One
1. Set credentials to your aws account to be available for the terraform aws provider, e.g. `aws configure`.
1. Comment the S3 backend block in `Infra/01-Terraform-state/dependencies.tf`.
2. Run:
   ```bash
   terraform -chdir=Infra/01-Terraform-state init
   terraform -chdir=Infra/01-Terraform-state apply -auto-approve
3. Uncomment the S3 backend block in `Infra/01-Terraform-state/dependencies.tf`.
4. Run:
   ```bash
   terraform -chdir=Infra/01-Terraform-state init -migrate-state -force-copy
### Obtaining GitHub Runner token

The token is used only for agent registration and is valid for 60 minutes. You can obtain it at the following address:

`https://github.com/<github-user>/<repo-name>/settings/actions/runners/new?arch=x64&os=linux`


## Additional information
Piepline is configured in such a way that when building a new version of the application it cuts the application version, e.g. `1.0.0`, from the `index.html` file in the main folder, if we change it to `1.0.1` a new version will be built which will be automatically deployed to the environment.

## Removal of the environment
In order to remove the environment, the following commands must be executed:
1. Run:
   ```bash
   terraform -chdir=Infra/02-Web-app-infra destroy -auto-approve
   terraform -chdir=Infra/01-Terraform-state init 
2. Comment the S3 backend block in `Infra/01-Terraform-state/dependencies.tf`.
3. Run:
   ```bash
   terraform -chdir=Infra/01-Terraform-state init -migrate-state -force-copy
   terraform -chdir=Infra/01-Terraform-state destroy -auto-approve