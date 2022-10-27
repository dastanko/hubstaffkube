# Implementation of task 2
Reference: https://gist.github.com/robertwe/194f1c6690380c995872112c7d167d81

## Requirements
* Terraform version >= v1.3.3

## Instructions to install app

* Install minikube 
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
* Start minikube with `--cni calico` flag (otherwise Network policies won't work.)
```
minikube start --cni calico
```                                                                                                                                                         
* Enable ingress 
```
minikube addons enable ingress
```
* Make adjustments in variables.tf
* Run `terraform apply`
* Run `minikube service app-service -- url` to get ingress exposed ip.

## How CI/CD would look like

**Assumptions**
* Have 3 environments to deploy: dev, staging, prod.
* Master branch is protected from direct pushes, only through merge requests.

**CI/CD setup**

* Any latest commit to any non-master branch, would trigger build and deployment to dev env. 
* Any merge request creation to master will trigger deployment to staging env. 
* Any merge to master deployment to prod. Thus master always will reflect state of the prod. 

**Deployment process**

The deployment  process would consist of terraform apply command and would require inputs: 
* Docker image tag - can be set via TF_image_tag environment variable. 
* Environment to deploy - can be set as predefined environment variable in CI/CD setup.
