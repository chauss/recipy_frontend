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
