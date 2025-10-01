provider "google" {
    project = "venkat-473005"
  
}

resource "google_compute_network" "vpc" {
    name                    = "my-vpc"
    auto_create_subnetworks = false
  
}

resource "google_compute_subnetwork" "subnet" {
    name          = "my-subnet"
    ip_cidr_range = "10.12.0.0/24"
    region        = "us-central1"
    network       = google_compute_network.vpc.id

}

resource "google_compute_firewall" "allow-http" {
    name    = "allow-http"
    network = google_compute_network.vpc.name
  
    allow {
      protocol = "tcp"
      ports    = ["80", "8080", "443","22"]
    }
  
    source_ranges = ["0.0.0.0/0"]
  
}

resource "google_compute_instance" "vm_instance" {
    name         = "my-vm-instance"
    machine_type = "e2-medium"
    zone         = "us-central1-a"
  
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    }
  
    network_interface {
      network    = google_compute_network.vpc.id
      subnetwork = google_compute_subnetwork.subnet.id
  
      access_config {
        // Ephemeral public IP
      }
    }
  
    tags = ["http-server"]
  
    metadata_startup_script = <<-EOF
      #!/bin/bash
      sudo apt-get update
      sudo apt-get install -y apache2
      sudo systemctl start apache2
      sudo systemctl enable apache2
      sudo echo '<!doctype html><html><body><h1>Hello, World from GCP VM!</h1></body></html>' > /var/www/html/index.html
    EOF
}