output "database_instance_name" {
  value       = google_sql_database_instance.recipy_instance.name
  description = "The name of the database instance"
}
output "database_instance_ip_address" {
  value       = google_sql_database_instance.recipy_instance.private_ip_address
  description = "The private ip address of the sql database instance"
}
output "database_name" {
  value       = google_sql_database.database.name
  description = "The name of the database within the instance"
}
output "database_instance_connection_name" {
  value       = google_sql_database_instance.recipy_instance.connection_name
  description = "The connection name of the database instance following the format <PROJECT_ID>:<REGION_ID>:<INSTANCE_ID>"
}
output "database_postgres_username" {
  value       = google_sql_user.postgres_user.name
  description = "The name of the default 'postgres' user"
}
output "database_postgres_user_password" {
  value       = google_sql_user.postgres_user.password
  description = "The password of the default 'postgres' user"
  sensitive   = true
}
