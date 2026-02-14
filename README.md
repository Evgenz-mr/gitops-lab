# GitOps Lab — MicroK8s + ArgoCD + Helm

## 📋 Требования

- Ubuntu 22.04/24.04 (или WSL2 с Ubuntu)
- 4+ GB RAM
- Docker (для сборки образов)

## 🚀 Быстрый старт

```bash
# 1. Установка MicroK8s
./infra/microk8s-setup.sh

# 2. Установка ArgoCD
microk8s kubectl create namespace argocd
microk8s kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 3. Применение конфигурации ArgoCD
microk8s kubectl apply -k argocd/

# 4. Доступ к UI
microk8s kubectl port-forward svc/argocd-server -n argocd 8080:443

# 5. Пароль администратора
microk8s kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
