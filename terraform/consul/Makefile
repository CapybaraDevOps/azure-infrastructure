CON_ENV ?= dev-01-west-eu-consul
init:
	terraform init
	terraform workspace select ${CON_ENV} || terraform workspace new ${CON_ENV}

plan: init
	terraform plan -var-file ../workspace_vars/$(CON_ENV).json

apply: plan
	terraform apply -var-file ../workspace_vars/$(CON_ENV).json --auto-approve

destroy: plan
	terraform destroy -var-file ../workspace_vars/$(CON_ENV).json --auto-approve
