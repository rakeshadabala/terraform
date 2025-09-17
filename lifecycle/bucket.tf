resource "google_storage_bucket" "buc" {
    name = "peak-key-463905-i9-venkat-bucket"
    location = "US"
    # storage_class = "STANDRAD"
    versioning {
      enabled = true
    }
  
}