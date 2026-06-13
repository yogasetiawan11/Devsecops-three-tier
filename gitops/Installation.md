# 1. Execute the manifest file
```sh
kubectl apply -f namespace.yaml
```

```sh
kubectl apply -f argo-cd.yaml
```
# 2. install Argocd CRD first 
```sh
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

# 3. Access argocd from browser with port-forward
```sh
kubectl port-forward service/argocd-server 80/8085
```
