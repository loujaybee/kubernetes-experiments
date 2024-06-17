#!/bin/bash

export AWS_REGION=us-east-1

kubectl delete services --all
kubectl delete deployments --all

aws ecr batch-delete-image --region us-east-1 \
    --repository-name microservice-a \
    --image-ids "$(aws ecr list-images --region us-east-1 --repository-name microservice-a --query 'imageIds[*]' --output json
)" || true

aws ecr batch-delete-image --region us-east-1 \
    --repository-name microservice-b \
    --image-ids "$(aws ecr list-images --region us-east-1 --repository-name microservice-b --query 'imageIds[*]' --output json
)" || true

aws ecr delete-repository --repository-name microservice-a --region us-east-1
aws ecr delete-repository --repository-name microservice-b --region us-east-1

terraform destroy -auto-approve