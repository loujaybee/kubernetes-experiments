#!/bin/bash

export AWS_REGION=us-east-1

kubectl delete services --all
kubectl delete deployments --all

aws ecr list-images --repository-name microservice-a --query 'imageIds[*]' --output text | while read imageId; do aws ecr batch-delete-image --repository-name microservice-a --image-ids imageDigest=$imageId; done
aws ecr list-images --repository-name microservice-b --query 'imageIds[*]' --output text | while read imageId; do aws ecr batch-delete-image --repository-name microservice-b --image-ids imageDigest=$imageId; done

aws ecr delete-repository --repository-name microservice-a --region us-east-1
aws ecr delete-repository --repository-name microservice-b --region us-east-1

terraform destroy -auto-approve