# -----------------------
# Helm release: kube-prometheus-stack
# -----------------------
resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true
  values           = [file("${path.cwd}/monitoring.yaml")]
  timeout          = 600
}

# -----------------------
# Deployment: my-app
# -----------------------
resource "kubernetes_deployment" "my_app" {
  depends_on = [helm_release.kube_prometheus_stack]

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
  depends_on = [kubernetes_deployment.my_app]

  metadata {
    name = "my-app-service"
  }

  spec {
    selector = {
      app = "my-app"
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
    }
  }
}