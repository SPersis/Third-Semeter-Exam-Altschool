#!/bin/bash

# Terraform plan 
terraform plan

# Terraform apply
terraform apply -auto-approve

# Ansible playbook
ansible-playbook use_K8s_cluster_roles.yml
