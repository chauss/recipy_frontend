output "recipy_vpc_id" {
  value       = google_compute_network.recipy_vpc.id
  description = "The id of the vpc for recipy"
}
output "vpc_access_connector_name" {
  value       = google_vpc_access_connector.recipy_vpc_serverless_access_connector.name
  description = "The name of the recipy-vpc-access-connector"
}
