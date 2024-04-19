aws eks update-kubeconfig --region us-east-1 --name my-cluster-eks

AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r) envsubst < app.template.yaml > app.yaml

kubectl apply -f app.yaml