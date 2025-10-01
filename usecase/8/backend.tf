terraform {
  backend "gcs" {
    bucket = "venkat-473005"
    prefix = "terraform/state"
    
  }
}

# provider "google" {
#     project = "venkat-473005"
  
# }