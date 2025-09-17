provider "google" {
    
  project = "peak-key-463905-i9"
  region  = "us-central1"
  
}

resource "google_compute_network" "tf-vpc" {
    name = "tf"
    auto_create_subnetworks = false
  
}
data "google_compute_network" "tf2-vpc" {
    name = "venkat"
  
}
# resource "google_compute_network" "tf2-vpc" {
#     name = "venkat"
  
# }



resource "google_compute_subnetwork" "sub_tf" {
    name = "tf-sub"
    region = "us-central1"
    ip_cidr_range = "10.2.0.0/16"
    network = google_compute_network.tf-vpc.id
  
}

resource "google_compute_instance" "tfin" {
  name         = "terraform"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-12"
    }
  }
  network_interface {
    network = google_compute_network.tf-vpc.id
    subnetwork = google_compute_subnetwork.sub_tf.id
 access_config {
   
 }

  }
}

resource "google_compute_instance" "tfin1" {
  name         = "terra"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-12"
    }
  }
  network_interface {
    network = data.google_compute_network.tf2-vpc.id
 access_config {
   
 }

  }
}