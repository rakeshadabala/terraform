provider "google" {
  project = "peak-key-463905-i9"
  region = "us-central1"
  
}

# resource "google_compute_instance" "vm" {
#     name = ""
#     zone = ""
#     machine_type = ""
#     boot_disk {
#       initialize_params {
#         image = ""
#       }
#     }
#     network_interface {
#       network = "default"
#     }
#     lifecycle {
#      # prevent_destroy = true
#       create_before_destroy = true
#       ignore_changes = [ machine_type ]
#     }
  
# }// ...existing code...

# resource "google_storage_bucket" "bucket" {
#   name     = "my-unique-bucket-name-123456" # Change to a globally unique name
#   location = "US"
#   force_destroy = false
#   versioning {
#     enabled = true
#   }
  # lifecycle_rule {
  #   action {
  #     type = "Delete"
  #   }
  #   condition {
  #     age = 365
  #   }
  # }
#}

// ...existing code...