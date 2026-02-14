#!/bin/bash
set -e

echo "🚀 Установка MicroK8s..."
sudo snap install microk8s --classic --channel=1.29/stable

echo "🔄 Добавление пользователя в группу microk8s..."
sudo usermod -a -G microk8s $USER
newgrp microk8s 2>/dev/null || echo "Требуется перелогиниться для применения групп"

echo "🔧 Включение аддонов..."
microk8s enable dns storage registry

echo "🌐 Установка MetalLB для LoadBalancer (локальный доступ к сервисам)..."
microk8s enable metallb
read -p "Введите диапазон IP для MetalLB (например, 192.168.1.200-192.168.1.210): " ip_range
echo "$ip_range" | microk8s kubectl apply -f - <<EOF
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  - $ip_range
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
EOF

echo "✅ MicroK8s готов! Следующие шаги:"
echo "1. microk8s kubectl apply -k https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
echo "2. microk8s kubectl apply -k argocd/"
echo "3. microk8s kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo "4. Откройте https://localhost:8080 (логин: admin, пароль: см. ниже)"
echo "   microk8s kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
