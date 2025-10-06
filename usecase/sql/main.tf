provider "google" {
    project = "venkat-473005"
    region = "us-central1"

  
}

resource "google_sql_database_instance" "sql_instance" {
    name = "my-sql"
    database_version = "MYSQL_8_0"
    region = "us-central1"
    settings {
        tier = "db-perf-optimized-N-8"
      #tier = "db-f1-micro"
      edition = "ENTERPRISE_PLUS"
      ip_configuration {
        ipv4_enabled = true
        authorized_networks {
          name = "all"
          value = "0.0.0.0/0"
        }
      }
    }  

    deletion_protection = false
}

resource "google_sql_user" "mysqluser" {
    name = var.db_user
    instance = google_sql_database_instance.sql_instance.name
    password = var.db_password
  
}

resource "google_sql_database" "database" {
    name= "mydb"
    instance = google_sql_database_instance.sql_instance.name
  
}