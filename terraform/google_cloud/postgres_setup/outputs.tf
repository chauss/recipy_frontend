output "cloud_run_sa_email" {
  value       = google_service_account.recipy_backend_sa.email
  description = "The email of the service account for cloud run"
}