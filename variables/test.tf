# provider "google" {
#     project = "peak-key-463905-i9"
#     region = "us-central1"

# }

# resource "google_compute_instance" "tf_vm12" {
#     name = "sai-vm"
#     zone = "us-central1-a"
#     machine_type = var.machine_type[var.env]
#     boot_disk {
#       initialize_params {
#         image = "debian-12"
#       }
#     }
#     network_interface {
#     network = "default"
#     access_config {

#     }
#     }
#     metadata_startup_script = file("${path.module}/startup.sh")

# }

