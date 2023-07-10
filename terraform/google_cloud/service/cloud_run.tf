# Service Account for the cloud run service
resource "google_service_account" "recipy_backend_sa" {
  account_id   = "recipy-backend-sa"
  display_name = "recipy-backend-sa"
}

# Add all specified roles to the service account for the cloud run service
resource "google_project_iam_member" "attach_iam_roles_to_service" {
  member   = "serviceAccount:${google_service_account.recipy_backend_sa.email}"
  for_each = toset(local.sa_roles)
  role     = each.value
  project  = var.project_id
}

# Create user for the service account in cloud sql
resource "google_sql_user" "users" {
  # Note: Due to the length limit on a database username, for service accounts, Cloud SQL
  # truncates the .gserviceaccount.com suffix in the email. For example, the username for
  # the service account sa-name@project-id.iam.gserviceaccount.com becomes sa-name@project-id.iam. 
  name     = "${google_service_account.recipy_backend_sa.account_id}@${var.project_id}.iam"
  instance = data.terraform_remote_state.database.outputs.database_instance_name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}

# Cloud run service
resource "google_cloud_run_service" "recipy_backend_service" {
  name                       = "recipy-backend"
  location                   = "europe-west3"
  autogenerate_revision_name = true
  template {
    spec {
      service_account_name = google_service_account.recipy_backend_sa.email
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
          value = "${google_service_account.recipy_backend_sa.account_id}@${var.project_id}.iam"
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
