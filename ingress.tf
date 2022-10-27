resource "kubernetes_ingress_v1" "app-ingress" {
  metadata {
    name = "app-ingress"
    labels = {
      name = "app"
    }
  }
  spec {

    rule {
      http {
        path {
          path = "/"
          backend {
            service {
              name = "app-service"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}