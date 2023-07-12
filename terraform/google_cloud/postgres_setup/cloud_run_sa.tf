# Service Account for the cloud run service
resource "google_service_account" "recipy_backend_sa" {
  account_id   = "recipy-backend-sa"
  display_name = "recipy-backend-sa"
}

# Create user for the service account in cloud sql
resource "google_sql_user" "cloud_run_sa_user" {
  # Note: Due to the length limit on a database username, for service accounts, Cloud SQL
  # truncates the .gserviceaccount.com suffix in the email. For example, the username for
  # the service account sa-name@project-id.iam.gserviceaccount.com becomes sa-name@project-id.iam. 
  name     = "${google_service_account.recipy_backend_sa.account_id}@${var.project_id}.iam"
  instance = data.terraform_remote_state.database.outputs.database_instance_name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}

resource "postgresql_grant_role" "cloud_run_sa_user_editor_role" {
  role       = google_sql_user.cloud_run_sa_user.name
  grant_role = postgresql_role.recipy_editor_role.name
}