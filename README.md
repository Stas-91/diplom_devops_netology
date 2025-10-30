# Решение


***

1. **Terraform Bootstrap**  
   Выполняется начальная инициализация инфраструктуры: создаётся сервисный аккаунт и S3-совместимый бакет (в Yandex Object Storage) для хранения состояния Terraform (`tfstate`).

2. **Подготовка тестового приложения**  
   Разрабатывается простое тестовое приложение, для которого создаётся `Dockerfile`, обеспечивающий его сборку в контейнерный образ.  
   [app_ci/cd repo](https://github.com/Stas-91/app/tree/master)

4. **Развёртывание инфраструктуры в Yandex Cloud с помощью Terraform**  
   - Образ приложения публикуется в публичном репозитории **Docker Hub**.  
   - Создаётся **Kubernetes-кластер** в Yandex Managed Service for Kubernetes.  
   - В кластер устанавливается Helm-релиз **`kube-prometheus-stack`** для мониторинга и сбора метрик.  
   - Тестовое приложение деплоится в кластер, а для обеспечения внешнего доступа настраивается **сервис с балансировщиком Network Load Balancer (NLB)**.  
     ![diplom](https://github.com/Stas-91/diplom_devops_netology/blob/main/img/terr_output.jpg)
     ![diplom](https://github.com/Stas-91/diplom_devops_netology/blob/main/img/k8s_work.jpg)
     ![diplom](https://github.com/Stas-91/diplom_devops_netology/blob/main/img/nodes_ip.jpg)
     ![diplom](https://github.com/Stas-91/diplom_devops_netology/blob/main/img/grafana_view.jpg)
     ![diplom](https://github.com/Stas-91/diplom_devops_netology/blob/main/img/app_work.jpg)
     

5. **Настройка CI/CD в GitHub**  
   В репозитории с тестовым приложением конфигурируется **GitHub Actions**:  
   - При каждом пуше в основную ветку автоматически собирается новый Docker-образ.  
   - Образ публикуется в **Docker Hub**.  
   - Инициируется **rollout обновления** в Kubernetes-кластере для применения новой версии приложения.  
  
![diplom](https://github.com/Stas-91/diplom_devops_netology/blob/main/img/cicd_github_action.jpg)

***
Весь код приложен в текущем репозитории и репозитории с приложением и CI/CD -   [app_ci/cd repo](https://github.com/Stas-91/app/tree/master)
