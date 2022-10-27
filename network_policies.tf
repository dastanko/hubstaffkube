resource "kubernetes_network_policy" "postgres-policy" {
  metadata {
    name   = "postgres-policy"
    labels = {
      name = "postgres"
    }
  }
  spec {
    policy_types = ["Ingress"]
    pod_selector {
      match_labels = {
        name = "postgres"
      }
    }
    ingress {
      from {
        pod_selector {
          match_labels = {
            name = "app"
          }
        }
      }
      ports {
        protocol = "TCP"
        port     = 5432
      }
    }
  }
}

resource "kubernetes_network_policy" "app-policy" {
  metadata {
    name   = "app-policy"
    labels = {
      name = "app"
    }
  }
  spec {
    policy_types = ["Ingress"]
    pod_selector {
      match_labels = {
        name = "app"
      }
    }
    ingress {
      from {
        pod_selector {
          match_labels = {
            "app.kubernetes.io/name" = "ingress-nginx"
          }
        }
      }
      ports {
        protocol = "TCP"
        port     = 80
      }
    }
  }
}