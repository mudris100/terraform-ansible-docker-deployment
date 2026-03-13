#!/bin/bash

IP=$(terraform output -raw ubuntu_public_ip)

ansible-playbook deploy.yml -i "$IP,"