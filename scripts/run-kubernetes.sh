#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
docker_path="shironguyen/ml-capstone"

# Step 2
# Run the Docker Hub container with kubernetes
#kubectl run ml-capstone --image=$dockerpath --port=2795
r=$(
  kubectl get pod ml-capstone 2>/dev/null
  echo $?
)

if [ "_$r" == "_1" ]; then
  kubectl run ml-api \
    --image=$docker_path \
    --port=2795
    --image-pull-policy="Always" \
    --overrides='{"apiVersion": "v1", "spec":{"imagePullSecrets": [{"name": "regcred"}]}}'
fi


# Step 3:
# List kubernetes pods
kubectl get pods


# Step 4:
# Forward the container port to a host
#kubectl expose deployment ml-capstone --type=LoadBalancer --port=2795
kubectl port-forward ml-capstone 2795:2795

# Open the service
# minikube service ml-capstone
