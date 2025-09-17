terraform {
    required_providers {
      google = {
        version = "~>5.0"                  #hasicrop google version
        source = "hashicorp/google"
      }
    }
    required_version = "~>1.13.0"           #terraform-version
  backend "gcs" {
    bucket = "peak-key-463905-i9-backend"   #bucketname in gcp
    prefix = "venkat/sai/"                  #path
    
  }
}

provider "google" {
    project = "peak-key-463905-i9"
    region = "us-central1"
  
}

resource "google_compute_network" "name" {
    name = "sai-vpc"
    auto_create_subnetworks = true
}
