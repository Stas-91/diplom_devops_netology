resource "kubernetes_deployment" "my_app" {
  metadata {
    name = "my-app"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "my-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "my-app"
        }
        annotations = {
          "kubectl.kubernetes.io/restartedAt" = timestamp()
        }        
      }
      spec {
        container {
          name  = "my-app-container"
          image = "stas91/app:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "my_app_service" {
  metadata {
    name = "my-app-service"
  }
  spec {
    selector = {
      app = "my-app"
    }
    type = "LoadBalancer"
    port {
      port = 80
      target_port = 80
    }
  }
}