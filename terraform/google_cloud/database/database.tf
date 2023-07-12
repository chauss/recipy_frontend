data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "google_sql_database_instance" "recipy_instance" {
  name             = local.database_instance_name
  database_version = "POSTGRES_15"
  settings {
    tier              = "db-f1-micro" # This machine type is only for testing purposes
    availability_type = "REGIONAL"
    disk_size         = 10 # 10 GB is the smallest disk size
    ip_configuration {
      ipv4_enabled    = var.db_instance_with_public_ip
      private_network = data.terraform_remote_state.network.outputs.recipy_vpc_id
      dynamic "authorized_networks" {
        for_each = var.db_instance_with_public_ip ? [1] : []
        content {
          name  = "Terraform executor IP-Adress"
          value = trim(data.http.myip.response_body, " \n")
        }
      }
    }
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }

  deletion_protection = "false"
}

resource "google_sql_database" "database" {
  name     = local.database_name
  instance = google_sql_database_instance.recipy_instance.name
}

# ACCESS
resource "google_sql_user" "postgres_user" {
  name     = "postgres"
  password = var.postgres_user_password
  instance = google_sql_database_instance.recipy_instance.name
  type     = "BUILT_IN"
}
