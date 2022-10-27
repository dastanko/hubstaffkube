resource "kubernetes_service" "app-service" {
  metadata {
    name   = "app-service"
    labels = {
      name = "app"
    }
  }
  spec {
    type     = "NodePort"
    selector = {
      name = "app"
    }

    port {
      port = 80
    }
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name   = "app-deployment"
    labels = {
      name = "app"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        name = "app"
      }
    }
    template {
      metadata {
        labels = {
          name = "app"
        }
      }
      spec {
        container {
          name              = "app"
          image             = "${var.image}:${var.image_tag}"
          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
}