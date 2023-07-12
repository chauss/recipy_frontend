variable "project_id" {
  type = string
}
variable "database_username" {
  sensitive = true
  type      = string
}
variable "db_instance_with_public_ip" {
  type = bool
}
variable "postgres_user_password" {
  sensitive   = true
  type        = string
  description = "The password for the default user 'postgres'"
}
