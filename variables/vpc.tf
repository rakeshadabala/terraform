# resource "google_compute_network" "vg-vpc" {
#     name = "venkat"
#     auto_create_subnetworks = var.h1
#     description = "crated form terraform"

# }

# resource "google_compute_subnetwork" "vg-subnet" {
#     name = "v-subnet"
#     network = google_compute_network.vg-vpc.id
#     region = "us-central1"
#     ip_cidr_range = "10.7.0.0/16"

# }

# resource "google_compute_firewall" "new-firewall" {
#     name = "firewall-allow"
#     network = google_compute_network.vg-vpc.id
#     direction = "INGRESS"
#     allow {
#       protocol = "tcp"
#       ports = ["22","80"]
#     }
#   source_ranges = ["0.0.0.0/0"]
# }
