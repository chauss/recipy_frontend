resource "google_cloud_run_service" "recipy_backend_service" {
  name                       = "recipy-backend"
  location                   = "europe-west3"
  autogenerate_revision_name = true
  template {
    spec {
      containers {
        image = var.image_name
        resources {
          limits = {
            memory = "4G"
            cpu    = "1"
          }
        }
        env {
          name  = "DB_IP_ADDRESS"
          value = data.terraform_remote_state.database.outputs.database_instance_ip_address
        }
        env {
          name  = "DATA_IMAGES_PATH"
          value = var.image_data_path
        }
        env {
          name  = "GOOGLE_APPLICATION_CREDENTIALS"
          value = "todo"
        }
      }
      timeout_seconds = 3600
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale"        = "1"
        "autoscaling.knative.dev/maxScale"        = "1"
        "run.googleapis.com/cpu-throttling"       = false
        "run.googleapis.com/vpc-access-egress"    = "all"                                                                 # enforce egress via vpc
        "run.googleapis.com/vpc-access-connector" = data.terraform_remote_state.network.outputs.vpc_access_connector_name # enforce egress via vpc
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
