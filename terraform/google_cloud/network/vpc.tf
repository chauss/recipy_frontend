resource "google_compute_network" "recipy_vpc" {
  name                    = "recipy-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_global_address" "private_ip_block" {
  name          = "private-ip-block"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  ip_version    = "IPV4"
  prefix_length = 20
  network       = google_compute_network.recipy_vpc.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.recipy_vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
}

resource "google_vpc_access_connector" "recipy_vpc_serverless_access_connector" {
  name          = "recipy-vpc-connector"
  network       = google_compute_network.recipy_vpc.name
  ip_cidr_range = "10.1.0.0/28"
}
