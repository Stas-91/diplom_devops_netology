output "my_app_service_lb_ip" {
  description = "Внешний IP Network Load Balancer для сервиса my-app-service"
  value       = kubernetes_service.my_app_service.status[0].load_balancer[0].ingress[0].ip
}