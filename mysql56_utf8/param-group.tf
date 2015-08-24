resource "aws_db_parameter_group" "mysql56_utf8" {
  name = "mysql56-utf8"
  family = "mysql5.6"
  description = "RDS utf-8 parameter group"

  parameter {
    name = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_filesystem"
    value = "binary"
  }

  parameter {
    name = "collation_connection"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name = "collation_server"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name = "init_connect"
    value = "set names 'utf8mb4' collate 'utf8mb4_general_ci'"
  }
}