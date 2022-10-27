resource "kubernetes_config_map" "postgres-config" {
  metadata {
    name   = "postgres-config"
    labels = {
      name = "postgres"
    }
  }

  data = {
    POSTGRES_DB       = var.db_name
    POSTGRES_USER     = var.db_username
    POSTGRES_PASSWORD = var.db_password
  }
}

resource "kubernetes_persistent_volume_claim" "postgres-pv-claim" {
  metadata {
    name   = "postgres-pv-claim"
    labels = {
      name = "postgres"
    }
  }
  spec {
    storage_class_name = "manual"
    access_modes       = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

resource "kubernetes_service" "postgres-service" {
  metadata {
    name   = "postgres-service"
    labels = {
      name = "postgres"
    }
  }
  spec {
    type     = "ClusterIP"
    selector = {
      name = "postgres"
    }
    port {
      port        = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_deployment" "postgres" {
  metadata {
    name   = "postgres"
    labels = {
      name = "postgres"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "postgres"
      }
    }
    template {
      metadata {
        labels = {
          name = "postgres"
        }
      }
      spec {
        container {
          name              = "postgres"
          image             = "postgres:10.1"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 5432
          }
          env_from {
            config_map_ref {
              name = "postgres-config"
            }
          }
          volume_mount {
            mount_path = "/var/lib/postgresql/data"
            name       = "postgresql"
          }
        }
        volume {
          name = "postgresql"
          persistent_volume_claim {
            claim_name = "postgres-pv-claim"
          }
        }
      }
    }
  }
}