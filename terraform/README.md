# README

## Overview
This repository contains Terraform scripts to provision an Azure Kubernetes Service (AKS) cluster with a Consul deployment using Helm. The configuration includes setting up the necessary network resources, security groups, and deploying Consul in a Kubernetes namespace.

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) installed
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed
- [Helm](https://helm.sh/docs/intro/install/) installed
- An Azure subscription

## Resources Provisioned
- Azure Resource Group
- User Assigned Managed Identity
- Azure Kubernetes Service (AKS) cluster
- Virtual Network (VNet) and Subnets
- Network Security Group (NSG) with necessary rules
- Kubernetes Namespace for Consul
- Consul deployment using Helm

## Configuration

### Terraform Variables
Before running Terraform, ensure you have the following variables set in a `terraform.tfvars` file or environment variables:

- `network_region`: The region where the network resources will be deployed.
- `vnet_cidrs`: The CIDR blocks for the virtual network.
- `subnet_delegation`: The delegation settings for subnets.
- `vnet_subnets`: A map of subnet names and their CIDR blocks.
- `cluster_id`: The unique identifier for the cluster.

### Helm Values
The Helm chart for Consul is configured using a `values-v1.yaml` file. Ensure this file is present in the `helm` directory with the necessary configuration.

## Usage

### Step 1: Initialize Terraform
```sh
make init
```
### Step 2: Plan the Deployment
```sh
make plan
```
### Step 3: Apply the Deployment
```sh
make apply
```
### Step 4: Verify the Deployment
Once the deployment is complete, verify the resources:

- Check the AKS cluster status in the Azure portal.
- Ensure the Consul namespace is created in the Kubernetes cluster.
- Verify Consul pods are running:
```sh
kubectl get pods -n consul
```
