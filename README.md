## Authors

- [@shironguyen](https://github.com/thanh20080kg/udacity-cdoe-project-5)

## Badges

### CircleCI Status
[![CircleCI](https://dl.circleci.com/status-badge/img/gh/tuancat/project-capstone-udacity/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/tuancat/project-capstone-udacity/tree/main)

# Udacity Capstone Project

In this project you will apply the skills and knowledge which were developed throughout the Cloud DevOps Nanodegree program. These include:

* Working in AWS
* Using Circle CI to implement Continuous Integration and Continuous Deployment
* Building pipelines
* Working with CloudFormation to deploy clusters/infrastructure
* Building Docker containers in pipelines
* Building Kubernetes clusters

## Project Scope

## Environment Variables

To run this project, you will need to add the following environment variables to your CircleCI environment variables

* `AWS_DEFAULT_REGION`
* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `DOCKER_HUB_PASSWORD`
* `DOCKER_HUB_USERNAME`

## Folder structure

| File | Description |
| ---- | ----------- |
| `.circleci/config.yml` | CircleCI configuration |
| `cloudformation` | CloudFormation yaml templates for creating infrastructure |
| `cloudformation/network.yml` | Create network VPC |
| `cloudformation/network-params.json` | Create network VPC params |
| `cloudformation/eks-cluster.yml` | Create EKS cluster |
| `cloudformation/eks-cluster-params.json` | Create EKS cluster params |
| `cloudformation/aws-eks-nodegroup.yml` | Create EKS nodes group |
| `cloudformation/amazon-eks-nodegroup-params.json` | Create EKS nodes group params |
| `kubernetes` | Kubernetes resource files |
| `kubernetes/deployment.yml` | Kubernetes deployment declaration |
| `kubernetes/loadbalancer.yml` | Kubernetes loadbalancer declaration |
| `kubernetes/aws-authen-cm.yml` | Kubernetes configmap declaration |
| `app.py` | main application to answer request |
| `Dockerfile` | Dockerfile to build image|
| `make_prediction.sh` | API call to make prediction |
| `Makefile` | Build file of the project |
| `requirements.txt` | Python required libraries |
| `scripts/run-docker.sh` | Shell script to run docker container |
| `scripts/run-kubernetes.sh` | Shell script to deploy docker container |
| `scripts/create-stack.sh` | Shell script to create AWS CloudFormation stack|
| `scripts/update-stack.sh` | Shell script to update AWS CloudFormation stack|
| `scripts/delete-stack.sh` | Shell script to delete AWS CloudFormation stack|
| `scripts/upload-docker.sh` | Shell script for uploading docker image to dockerhub repository |

## Run Steps For Cloud Deployment
* Create a DockerHub public repository
* Run chmod 700 for each Shell scrip in `./scripts` folder
* Run `./create-stack.sh Capstone network.yml network-params.json` to create VPC infrastructure
* Run `./create-stack.sh Capstone-EKS eks-cluster.yml eks-cluster-params.json` to create EKS cluster
* Run `./create-stack.sh Capstone-NodeGroup aws-eks-nodegroup.yml aws-eks-nodegroup-params.json` to create EKS nodes group
* Run `aws eks list-clusters --profile udacity` to see output like below
* Configure CircleCI project for the github repository
* Done!

* Some kubectl commands to check k8s resources
```bash
    # Fet k8s configs
    aws eks --region us-east-1 update-kubeconfig --name capstone-project
    # Switch context
    kubectl config use-context arn:aws:eks:us-east-1:006808541377:cluster/capstone-project
    # Manually apply k8s resource
    kubectl apply -f aws-authen-cm.yml
    # See ndoes in cluster
    kubectl get nodes
    # See running pods
    kubectl get pods
    # See services
    kubectl get services
    # View logs of a pod (when checking incoming request)
    kubectl logs <POD_NAME>
     aws cloudformation deploy --template-file deploy-eks.yml --stack-name capstone-project --capabilities CAPABILITY_NAMED_IAM


```

Remember to replace names of DockerHub repository & cluster name to the script file before you run.