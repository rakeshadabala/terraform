# provider "google" {
#   project = var.project_id
#   region  = "us-west4"
  
# }
# data "google_compute_zones" "zoner" {
#     region = "us-west4"
  
# }




# resource "google_compute_instance" "default" {
#     count = 2
#   name         = "${var.instance_name}-${count.index+1}"
#   machine_type = var.machine_type
#   zone         = data.google_compute_zones.zoner.names[count.index]

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#     network = "default"

#     access_config {
#     }
#   }

# }