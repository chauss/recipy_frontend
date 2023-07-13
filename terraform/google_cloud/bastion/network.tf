resource "google_compute_subnetwork" "recipy_vpc_subnetwork_for_bastion_host" {
  name          = "bastion-host-subnetwork"
  ip_cidr_range = "10.2.0.0/24"
  network       = data.terraform_remote_state.network.outputs.recipy_vpc_id
}

resource "google_compute_firewall" "allow_ingress_from_iap" {
  name        = "allow-ingress-from-iap"
  network     = data.terraform_remote_state.network.outputs.recipy_vpc_self_link
  direction   = "INGRESS"
  priority    = 500
  target_tags = [local.bastion_host_tag]
  # Values from google doku: https://cloud.google.com/iap/docs/using-tcp-forwarding
  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }
  source_ranges = ["35.235.240.0/20"]
  log_config {
    metadata = "EXCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "allow_bastion_host_to_egress" {
  name      = "egress-deny-all"
  network   = data.terraform_remote_state.network.outputs.recipy_vpc_self_link
  direction = "EGRESS"
  priority  = 501
  allow {
    protocol = "tcp"
    ports = [ 443 ]
  }
  source_ranges = [data.terraform_remote_state.network.outputs.recipy_vpc_serverless_access_connector_ip_cidr_range]
  log_config {
    metadata = "EXCLUDE_ALL_METADATA"
  }
}