provider "google" {
    project = "venkat-473005"
  
}

resource "google_compute_address" "static_ip" {
    name = "static-ip"
    region = "us-central1"
  
}

resource "google_compute_instance" "vm" {
    name = "vm-instace"
    machine_type = "e2-micro"
    zone = "us-central1-a"

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    }
    network_interface {
      network = "default"
      access_config {
        nat_ip = google_compute_address.static_ip.address
      }
    }
  
}


##### Outputs
output "instance_ip" {
    value = google_compute_address.static_ip.address
}