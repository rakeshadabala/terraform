# comment
provider "google" {

  project = "peak-key-463905-i9"
  region  = "us-west4"

}

resource "google_compute_instance" "venkat-in" {
  #count = 5
  name         = "terraform"
  machine_type = "e2-medium"
  zone         = "us-west4-b"
  #"us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-12"
    }
  }

  network_interface {
    #network = google_compute_network.vg-vpc.id
    #subnetwork = google_compute_subnetwork.vg-subnet.id
    network = "default"
    access_config {
       nat_ip = google_compute_address.addre.address
    }
  }
  #depends_on = [ google_compute_subnetwork, google_compute_network ]
  #metadata_startup_script = file("${path.module}/startup.sh")
  # lifecycle {
  #   create_before_destroy = true
  #   prevent_destroy = false
  #   ignore_changes = [ metadata_startup_script ]
  
  #}
} 

resource "google_compute_address" "addre" {
    name = "venkayya"
    region = "us-west4"
  
}

# output "sai" {
#     value = [for instance in google_compute_instance.venkat-in : instance.name]
# }

