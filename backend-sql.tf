provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

resource "google_sql_database_instance" "instance" {
  name             = "instance-name"
  database_version = "MYSQL_5_7"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
    availability_type = "ZONAL"
    backup_configuration {
      enabled = true
      binary_log_enabled = true
    }
  }
}

resource "google_sql_database" "database" {
  name     = "database-name"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "user" {
  name     = "username"
  password = "password"
  instance = google_sql_database_instance.instance.name
  host     = "%"
}

resource "google_sql_database_instance_user" "root_user" {
  name     = "root"
  password = "password"
  instance = google_sql_database_instance.instance.name
}
