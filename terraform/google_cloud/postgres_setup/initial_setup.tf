resource "postgresql_schema" "recipy_schema" {
  name = var.recipy_schema
  database = data.terraform_remote_state.database.outputs.database_name
  owner = "postgres"
}

resource "postgresql_role" "recipy_editor_role" {
  name            = "recipy_editor"
  login           = true
  superuser       = false
  create_database = false
}

resource "postgresql_grant" "grant_usage_and_create_to_recipy_editor_role_on_recipy_schema" {
  database    = data.terraform_remote_state.database.outputs.database_name
  role        = postgresql_role.recipy_editor_role.name
  schema      = postgresql_schema.recipy_schema.name
  object_type = "schema"
  # objects     = [] // can not be specified when object_type = schema
  privileges  = ["ALL"]
}

resource "postgresql_grant" "grant_isud_to_recipy_editor_role_on_all_tables_in_recipy_schema" {
  database    = data.terraform_remote_state.database.outputs.database_name
  role        = postgresql_role.recipy_editor_role.name
  schema      = postgresql_schema.recipy_schema.name
  object_type = "table"
  objects     = []  // grant to all tables
  privileges  = ["ALL"]
}