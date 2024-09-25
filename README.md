# Terraform Azure Templates

This repository contains Terraform Azure Templates that can be used later to develop Infrastructure-as-a-Code (IaaS) projects.

# Prerequisites

- Terraform 0.14.9 or later
- The Azure CLI Tool installed

# Install the Azure CLI Tool

Open your PowerShell prompt as an administrator and run the following command:

```
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

# Authenticate using the Azure CLI

Terraform must authenticate to Azure to create infrastructure.
In your terminal, use the Azure CLI tool to setup your account permissions locally.

```
az login
```

Your browser will open and prompt you to enter your Azure login credentials. After successful authentication, your terminal will display your subscription information.

```
You have logged in. Now let us find all the subscriptions to which you have access...

[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "0envbwi39-home-Tenant-Id",
    "id": "35akss-subscription-id",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Subscription-Name",
    "state": "Enabled",
    "tenantId": "0envbwi39-TenantId",
    "user": {
      "name": "your-username@domain.com",
      "type": "user"
    }
  }
]
```

Find the <id> column for the subscription account you want to use.
Once you have chosen the account subscription ID, set the account with the Azure CLI.

```
az account set --subscription "35akss-subscription-id"
```

# Create a Service Principal

Next, create a Service Principal. A Service Principal is an application within Azure Active Directory with the authentication tokens Terraform needs to perform actions on your behalf. Update the <SUBSCRIPTION_ID> with the subscription ID you specified in the previous step.

```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"

Creating 'Contributor' role assignment under scope '/subscriptions/35akss-subscription-id'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx",
  "displayName": "azure-cli-2022-xxxx",
  "password": "xxxxxx~xxxxxx~xxxxx",
  "tenant": "xxxxx-xxxx-xxxxx-xxxx-xxxxx"
}
```

# Set your environment variables

HashiCorp recommends setting these values as environment variables rather than saving them in your Terraform configuration.
In your PowerShell terminal, set the following environment variables. Be sure to update the variable values with the values Azure returned in the previous command.

```
$Env:ARM_CLIENT_ID = "<APPID_VALUE>"
$Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
$Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
$Env:ARM_TENANT_ID = "<TENANT_VALUE>"
```

# Terraform Basic Commands

1. `terraform init` - Initialize your Terraform configuration.
2. `terraform fmt` - Format the configuration.
3. `terraform validate` - Validate the configuration.
4. `terraform apply` - Apply your Terraform Configuration.
5. `terraform show`/`terraform state list`/`terraform state` - Inspect your state.
6. `terraform destroy` - Terminates resources managed by your Terraform project.
