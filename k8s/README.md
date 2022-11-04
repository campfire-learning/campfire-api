# Campfire Deployment

We deploy Rails API and React app in separate Docker containers. They are both internal services in Kubernetes. The web app service is served via an ingress, which in turn is connected to the outside world via an AWS load balancer.

1. After merging code change, update and upload Docker images:
- In API's root directory, build a Docker image `docker build -t campfire-api .`
- Publish it `docker push campfire-api`
- In web app's root directory, build a Docker image `docker build -t campfire-web .`
- Publish it `docker push campfire-web`
2. Apply Kubernetes deployment - only update the changed component:
```
kubectl apply -f campfire-api.yaml
kubectl apply -f campfire-web.yaml
```

## How we set up the deployment
- Create & apply Terraform for EKS cluster
- `kubectl apply -f service_account.yaml`
- `kubectl apply -f db_secret.yaml`
- `kubectl apply -f config_map.yaml`
- `kubectl apply -f api.yaml` 
- `kubectl apply -f web.yaml`
- Install NGINX Ingress Controller
  - helm repo add nginx-stable https://helm.nginx.com/stable
  - helm repo update
  - helm install campfire-ingress nginx-stable/nginx-ingress
- `kubectl apply -f ingress.yaml`

For more information on NGINX Ingress, see [the official document](https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm).

