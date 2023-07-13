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
  prefix_length = 24
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
  ip_cidr_range = "10.1.0.0/28" # mask must be 28
}

resource "google_compute_router" "recipy_vpc_router" {
  name     = "${google_compute_network.recipy_vpc.name}-router"
  network  = google_compute_network.recipy_vpc.id
}

resource "google_compute_router_nat" "recipy_vpc_router_nat" {
  name     = "${google_compute_network.recipy_vpc.name}-router-nat"
  router   = google_compute_router.recipy_vpc_router.name
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ALL"
  }
}

# Default deny all egress
# The current cloud run setup does not work with this rule
# resource "google_compute_firewall" "fw_block_egress_from_vpc_connectors" {
#   name      = "egress-deny-all"
#   network   = google_compute_network.recipy_vpc.name
#   direction = "EGRESS"
#   priority  = 1000
#   deny {
#     protocol = "all"
#   }
#   source_ranges = [google_vpc_access_connector.recipy_vpc_serverless_access_connector.ip_cidr_range]
#   log_config {
#     metadata = "EXCLUDE_ALL_METADATA"
#   }
# }
