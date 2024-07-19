## Datadog Integration Setup

### Overview

This guide provides step-by-step instructions on how to set up the necessary secrets and keys for Datadog integration using Terraform. Before creating the integration, you must ensure that you have all the required secrets and keys properly configured in a `secret.json` file within the `key_vault` directory. After that, you can proceed with applying the Terraform configurations to complete the integration.

### Prerequisites

- Terraform installed on your machine.
- Access to the necessary keys and secrets for Datadog integration.

### Steps

#### 1. Create `secret.json` in the `key_vault` Directory

First, navigate to the `key_vault` directory in your project. Inside this directory, create a file named `secret.json`.

```bash
cd key_vault
touch secret.json
```

#### 2. Populate `secret.json` with Required Secrets and Keys

Open the `secret.json` file and populate it with the required secrets and keys. The structure of this file should include the necessary authentication tokens, API keys, and any other secrets required for Datadog integration. Here is an example structure:

```json
{
  "datadog_api_key": "your-datadog-api-key",
  "datadog_app_key": "your-datadog-app-key"
}
```

Replace the placeholder values with your actual Datadog API and application keys.

#### 3. Apply the Initial Terraform Configuration

Once the `secret.json` file is populated, navigate back to the root directory of your project and apply the initial Terraform configuration. This step is necessary to set up the environment and any prerequisites for the Datadog integration.

```bash
cd ..
terraform init
terraform apply
```

### Conclusion

By following the steps outlined above, you will successfully set up the necessary secrets and keys for Datadog integration and apply the Terraform configurations to complete the integration process. If you encounter any issues or have any questions, please refer to the Terraform and Datadog documentation or contact support for further assistance.

---

Make sure to keep your `secret.json` file secure and do not share it publicly or commit it to version control.
