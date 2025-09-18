provider "google" {
    project = var.project_id
    region = var.region

}

resource "google_compute_instance" "tf_vm" {
    name = var.name
    zone = var.zone
    machine_type = var.machine_type
    boot_disk {
      initialize_params {
        image = var.image
      }
    }
    network_interface {
      network = var.network
      subnetwork = var.subnetwork
      access_config {

      }
    }

}

