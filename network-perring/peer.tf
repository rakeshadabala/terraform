

resource "google_compute_network_peering" "name" {
    name = "vpc-vpc2"
    network = google_compute_network.vpc.id
    peer_network = google_compute_network.vpc2.id
}

resource "google_compute_network_peering" "name1" {
    name = "vpc2-vpc"
    network = google_compute_network.vpc2.id
    peer_network = google_compute_network.vpc.id
}


# resource "google_sql_database_instance" "default" {
#   name             = "my-sql-instance"
#   database_version = "MYSQL_8_0"
#   region           = "us-central1"

#   settings {
#     tier = "db-f1-micro"
#   }
# }

# resource "google_sql_database" "default" {
#   name     = "mydatabase"
#   instance = google_sql_database_instance.default.name
# }