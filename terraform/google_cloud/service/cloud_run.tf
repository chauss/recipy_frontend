# Add all specified roles to the service account for the cloud run service
resource "google_project_iam_member" "attach_iam_roles_to_service" {
  member   = "serviceAccount:${data.terraform_remote_state.postgres.outputs.cloud_run_sa_email}"
  for_each = toset(local.sa_roles)
  role     = each.value
  project  = var.project_id
}

# Cloud run service
resource "google_cloud_run_service" "recipy_backend_service" {
  depends_on = [ google_project_iam_member.attach_iam_roles_to_service ]
  name                       = "recipy-backend"
  location                   = "europe-west3"
  autogenerate_revision_name = true
  template {
    spec {
      service_account_name = data.terraform_remote_state.postgres.outputs.cloud_run_sa_email
      timeout_seconds      = 3600
      containers {
        image = local.image_name
        resources {
          limits = {
            memory = "4G"
            cpu    = "1"
          }
        }
        env {
          name  = "SPRING_PROFILES_ACTIVE"
          value = local.active_spring_profile
        }
        env {
          name  = "GCP_PROJECT_ID"
          value = var.project_id
        }
        env {
          name  = "DB_IP_ADDRESS"
          value = data.terraform_remote_state.database.outputs.database_instance_ip_address
        }
        env {
          name  = "CLOUD_SQL_INSTANCE_CONNECTION_NAME"
          value = data.terraform_remote_state.database.outputs.database_instance_connection_name
        }
        env {
          name  = "DB_NAME"
          value = data.terraform_remote_state.database.outputs.database_name
        }
        env {
          name  = "RECIPY_DATA_IMAGES_PATH"
          value = local.image_data_path
        }
        env {
          name  = "RECIPY_ENCRYPTION_FIREBASE_SECRET_KEY"
          value = var.firebase_credentials_decryption_key
        }
        env {
          name  = "DB_ACCESS_SA"
          value = trimsuffix(data.terraform_remote_state.postgres.outputs.cloud_run_sa_email, ".gserviceaccount.com")
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale"        = "0"
        "autoscaling.knative.dev/maxScale"        = "1"
        "run.googleapis.com/cpu-throttling"       = true
        # "run.googleapis.com/cloudsql-instances"   = data.terraform_remote_state.database.outputs.database_instance_connection_name
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
