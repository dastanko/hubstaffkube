resource "kubernetes_persistent_volume" "postgres-pv-volume" {
  metadata {
    name = "postgres-pv-volume"
    labels = {
      name = "postgres"
    }
  }
  spec {
    storage_class_name = "manual"
    access_modes       = ["ReadWriteMany"]
    capacity = {
      storage = "5Gi"
    }

    persistent_volume_source {
      host_path {
        path = "/data/postgres/"
      }
    }
  }
}