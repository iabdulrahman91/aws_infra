# Kubernetes and Terraform


This Repositery is to demonstrate my ability in:

- Building Infrastucture as Code (IaC): using Terraform and AWS Provider
- Deploying apps in Kubernetes Cluster: using AWS EKS

---

## Terraform

I utilized Terraform to Create Elastic Cloud Kubernetes (EKS) and all its prerequisites such as Roles, IGW, VPC, etc.

All created components are placed inside `terraform-aws/`.

Scafolding EKS cluster on AWS can be done using the following steps:

1 - Install and Configure AWS CLI [https://aws.amazon.com/cli/]

2 - Clone the repo

```shell
git clone https://github.com/iabdulrahman91/aws_infra.git
```

3 - Initialize Terraform (this will also pull AWS Provider [https://registry.terraform.io/providers/hashicorp/aws/4.0.0])

```shell
cd terraform-aws
terraform init
```

4 - Apply the Terraform code to build an EKS app on AWS

```shell
terraform apply
```

---

## Kubernates

K8s will be used for the deployment. I utilized K8s to orchestrate different deployments for **two** copy of the app + Autoscaler.

The First deployment is to demonstrate deplying:

[https://github.com/iabdulrahman91/sary_app_django]

[API URL](http://a173b9962a8184534a44a4226ef0c9cd-a797f83e3788bf39.elb.us-east-2.amazonaws.com)

- **Django app (Python)**
- **PostgreSQL using StatefulSet**

The Second deployment is to demonstrate deplying:

[https://github.com/iabdulrahman91/sary-app-laravel]

[API URL](http://a7fb6ec99dd5e44639b36cef3699092f-feb52c773df7eb64.elb.us-east-2.amazonaws.com/api/questions)


- **Laravel app (PHP)**
- **PostgreSQL using Deployment**

Every app reside in a `Namespace`

- `django` namespce:
    - app (Deployment)
    - database (StatefulSet)
    - secrets fils (Secret)
    - config files (ConfigMap)
    - Load balancer and ClusterIP (Service)
    - Storage (PersistentVolume , PersistentVolumeClaim)

- `laravel` namespce:
    - app (Deployment)
    - database (Deployment)
    - secrets fils (Secret)
    - config files (ConfigMap)
    - Load balancer and ClusterIP (Service)
    - Storage (PersistentVolume , PersistentVolumeClaim)

Deployment of both apps on EKS cluster can be done using the following steps:

1 - Install `kubectl` [https://kubernetes.io/docs/tasks/tools/]

2 - Configure `kubectl to control EKS cluster we created

```shell
aws eks --region us-east-2 update-kubeconfig --name main-cluster
```

2 - Clone the repo (if you haven't)

```shell
git clone https://github.com/iabdulrahman91/aws_infra.git
```

3 - Create Namespaces and deploy Autoscaler

```shell
kubectl apply -f k8s/
```

output example:

```shell
serviceaccount/cluster-autoscaler created
clusterrole.rbac.authorization.k8s.io/cluster-autoscaler created
role.rbac.authorization.k8s.io/cluster-autoscaler created
clusterrolebinding.rbac.authorization.k8s.io/cluster-autoscaler created
rolebinding.rbac.authorization.k8s.io/cluster-autoscaler created
deployment.apps/cluster-autoscaler created
namespace/django created
namespace/laravel created
```

3 - Deploy Django version of the App

```shell
kubectl apply -f k8s/django-app/
```

output example:

```shell
configmap/app-config created
deployment.apps/app-deployment created
secret/app-secrets created
service/app-service created
secret/database-secrets created
service/database-service created
statefulset.apps/database-statefulset created
persistentvolume/database-pv-1 created
persistentvolumeclaim/database-pvc-1 created
```

3 - Deploy Laravel version of the App

```shell
kubectl apply -f k8s/laravel-app/
 ```

output example:

```shell
configmap/app-config created
deployment.apps/app-deployment created
secret/app-secrets created
service/app-service created
deployment.apps/database-deployment created
secret/database-secrets created
service/database-service created
persistentvolume/database-pv-2 created
persistentvolumeclaim/database-pvc-2 created
```
