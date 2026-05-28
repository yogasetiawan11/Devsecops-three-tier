# ArgoCD Cleanup from kube-system

## Problem

ArgoCD was accidentally installed into the `kube-system` namespace — a critical namespace that should only contain cluster-level system components.

## Risks of Installing ArgoCD in kube-system

- Risk of accidentally deleting/modifying critical system resources
- Violates Kubernetes best practices and namespace isolation
- ArgoCD RBAC roles in kube-system could overlap with system service accounts
- Makes debugging cluster issues harder

## Cleanup Steps

### 1. Identify all ArgoCD resources in kube-system

```bash
kubectl get all -n kube-system | grep argocd
kubectl get cm,secret,sa,role,rolebinding -n kube-system | grep argocd
kubectl get clusterrole,clusterrolebinding | grep argocd
kubectl get crd | grep argocd
```

### 2. Delete ArgoCD workloads

```bash
kubectl delete deployment -n kube-system \
  argocd-application-controller \
  argocd-applicationset-controller \
  argocd-dex-server \
  argocd-notifications-controller \
  argocd-redis \
  argocd-repo-server \
  argocd-server \
  --ignore-not-found

kubectl delete statefulset -n kube-system \
  argocd-application-controller \
  --ignore-not-found
```

### 3. Delete ArgoCD services

```bash
kubectl delete service -n kube-system \
  argocd-applicationset-controller \
  argocd-dex-server \
  argocd-metrics \
  argocd-notifications-controller-metrics \
  argocd-redis \
  argocd-repo-server \
  argocd-server \
  argocd-server-metrics \
  --ignore-not-found
```

### 4. Delete ArgoCD configuration resources

```bash
kubectl delete configmap -n kube-system \
  argocd-cm argocd-cmd-params-cm argocd-gpg-keys-cm \
  argocd-notifications-cm argocd-rbac-cm \
  argocd-ssh-known-hosts-cm argocd-tls-certs-cm \
  --ignore-not-found

kubectl delete secret -n kube-system \
  argocd-notifications-secret argocd-secret \
  --ignore-not-found
```

### 5. Delete ArgoCD RBAC (namespace-scoped)

```bash
kubectl delete sa -n kube-system \
  argocd-application-controller \
  argocd-applicationset-controller \
  argocd-dex-server \
  argocd-notifications-controller \
  argocd-redis \
  argocd-repo-server \
  argocd-server \
  --ignore-not-found

kubectl delete role -n kube-system \
  argocd-application-controller \
  argocd-applicationset-controller \
  argocd-dex-server \
  argocd-notifications-controller \
  argocd-redis \
  argocd-server \
  --ignore-not-found

kubectl delete rolebinding -n kube-system \
  argocd-application-controller \
  argocd-applicationset-controller \
  argocd-dex-server \
  argocd-notifications-controller \
  argocd-redis \
  argocd-server \
  --ignore-not-found
```

### 6. Delete ArgoCD RBAC (cluster-scoped)

```bash
kubectl delete clusterrole \
  argocd-application-controller \
  argocd-applicationset-controller \
  argocd-server \
  --ignore-not-found

kubectl delete clusterrolebinding \
  argocd-application-controller \
  argocd-applicationset-controller \
  argocd-server \
  --ignore-not-found
```

### 7. Delete the stray argocd namespace

```bash
kubectl delete namespace argocd --ignore-not-found
```

### 8. Force-delete stuck Terminating pods (if any)

```bash
kubectl delete pod -n kube-system --grace-period=0 --force \
  argocd-application-controller-0 \
  argocd-applicationset-controller-... \
  argocd-dex-server-... \
  argocd-notifications-controller-... \
  argocd-redis-... \
  argocd-repo-server-... \
  argocd-server-...
```

### 9. Verify cleanup

```bash
kubectl get all,cm,secret,sa,role,rolebinding -n kube-system | grep argocd
kubectl get clusterrole,clusterrolebinding | grep argocd
kubectl get pods -n kube-system
```

## Correct Installation

ArgoCD should be installed in its own isolated namespace:

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd -n argocd --create-namespace
```
