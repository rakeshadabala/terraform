# comment
provider "google" {

  project = "peak-key-463905-i9"
  region  = var.envv[1].region

}

resource "google_compute_instance" "venkat-in" {
  name         = "terraform"
  machine_type = "e2-medium"
  zone         = var.envv[0].zone
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

    }
  }
  metadata_startup_script = file("${path.module}/startup.sh")
}