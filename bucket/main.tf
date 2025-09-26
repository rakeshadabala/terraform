provider "google" {
  project = "venkat-473005"
  region  = "us-central1"

}

# resource "google_storage_bucket" "bucket" {
#   name     = "at-your-peak-venkiiii" // Replace with a unique bucket name
#   location = "US"
#   uniform_bucket_level_access = true
#   force_destroy = true
#   storage_class = "standard"
# }
# resource "google_storage_bucket_object" "tf_object" {
#     name = "main"
#     bucket = google_storage_bucket.bucket.name
#     source = "./1.tf"

# }

# resource "google_storage_bucket_iam_member" "public_access" {
#   bucket = google_storage_bucket.bucket.name

#   role   = "roles/storage.objectViewer"
#   member = "allUsers"

# }











# resource "google_compute_network" "vppc" {
#     name = "venki-vpc"
#     auto_create_subnetworks = var.subnets

# }

# variable "subnets" {
#     type = bool
#   default = false
#   sensitive = true
# }

