# 📦 NGINX in Minikube

## Передумови

- Windows 10/11 з WSL2 (Ubuntu)
- Docker Desktop з увімкненою WSL інтеграцією
- Підключення до Інтернету

## Що включено
- Namespace для ізоляції
- PVC з динамічним PV (Minikube сам створює)
- ConfigMap із index.html
- Secret, змонтований як файл
- Deployment з 2 репліками
- ClusterIP Service

## Встановлення Kubernetes CLI (kubectl)

```bash
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
```

## Встановлення Minikube у WSL2 (Ubuntu)

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

## Запуск Minikube

```bash
minikube start --driver=docker
```

> **Примітка:** потрібно переконатися, що Docker Desktop увімкнено і має інтеграцію з WSL-дистрибутивом.

---

## Деплой NGINX у Kubernetes

### 1. Перехід у директорію з YAML-файлами

```bash
cd ~/projects/lecture19
```

### 2. Створення ресурсів

```bash
kubectl apply -f 1-namespace.yaml
kubectl apply -f 2-pvc.yaml
kubectl apply -f 3-configmap.yaml
kubectl apply -f 4-secret.yaml
kubectl apply -f 5-deployment.yaml
kubectl apply -f 6-service.yaml
```

---

## Перевірка статусу

```bash
kubectl get all -n nginx-demo
kubectl get pvc -n nginx-demo
kubectl describe pod -n nginx-demo
```

---

## Доступ до застосунку

```bash
kubectl port-forward -n nginx-demo svc/nginx-service 8080:80
```

Відкрити в браузері: [http://localhost:8080](http://localhost:8080)

---

## Зупинка Minikube

```bash
minikube stop
```

## Prepared on: 5/15/2025 By: Andrii Fil (IT Administrator, DevOps trainee)
