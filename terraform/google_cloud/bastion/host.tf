resource "google_service_account" "bastion_host_sa" {
  account_id   = "bastion-host-sa"
  display_name = "Bastion Host Service Account"
}

resource "google_project_iam_member" "attach_iam_roles_to_service" {
  member   = "serviceAccount:${google_service_account.bastion_host_sa.email}"
  for_each = toset(local.sa_roles)
  role     = each.value
  project  = var.project_id
}

resource "google_compute_instance" "bastion_host" {
  depends_on   = [google_project_iam_member.attach_iam_roles_to_service]
  name         = "bastion-host"
  machine_type = "e2-micro"
  zone         = "${local.region}-a"

  tags = [local.bastion_host_tag]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = data.terraform_remote_state.network.outputs.recipy_vpc_self_link
    subnetwork = google_compute_subnetwork.recipy_vpc_subnetwork_for_bastion_host.self_link
    # access_config {
    #   // Ephemeral public IP
    # }
  }

  metadata_startup_script = <<EOT
    curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.5.0/cloud-sql-proxy.linux.amd64
    chmod +x cloud-sql-proxy
    ./cloud-sql-proxy --private-ip ${data.terraform_remote_state.database.outputs.database_instance_connection_name}
    EOT

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.bastion_host_sa.email
    scopes = ["cloud-platform"]
  }
}
