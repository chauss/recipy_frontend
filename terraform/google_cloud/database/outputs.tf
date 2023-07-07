output "database_instance_ip_address" {
  value       = google_sql_database_instance.recipy_instance.private_ip_address
  description = "The private ip address of the sql database instance"
}
