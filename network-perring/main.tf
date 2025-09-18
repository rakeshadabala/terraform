provider "google" {
    project = "peak-key-463905-i9"
    # region = "us-central1"
}
resource "google_compute_network" "vpc" {
    name = "net"
    auto_create_subnetworks = false  
}

resource "google_compute_subnetwork" "sub1" {
    name = "subnet1"
    network = google_compute_network.vpc.id
    ip_cidr_range = "10.51.0.0/24"
    region = "us-west4"

    depends_on = [ google_compute_network.vpc ]
  
}

resource "google_compute_network" "vpc2" {
    name = "net2"
    auto_create_subnetworks = false  
}

resource "google_compute_subnetwork" "sub2" {
    name = "subnet2"
    network = google_compute_network.vpc2.id
    ip_cidr_range = "10.30.0.0/24"
    region = "us-central1"
  
  depends_on = [ google_compute_network.vpc2 ]
  
}

locals {
  networks = {
    vpc = google_compute_network.vpc.id
    vpc2 = google_compute_network.vpc2.id
  }
}

resource "google_compute_firewall" "fir" {
    for_each = local.networks
    name = "firewall-${each.key}"
    network = each.value
    direction = "INGRESS"
    allow {
      protocol = "all"
      #ports = ["22","80"]
      
    }
    source_ranges = ["0.0.0.0/0"]
    #target_tags = ["allow-ssh-http"]

    depends_on = [ google_compute_network.vpc, google_compute_network.vpc2 ]
}

resource "google_compute_instance" "vm" {
  name = "p1"
  zone = "us-central1-a"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      #image = "ubuntu-2404-lts-amd64"
     image =  "projects/ubuntu-os-cloud/global/images/ubuntu-2504-plucky-amd64-v20250828"
    }
  }
  network_interface {
    network = google_compute_network.vpc2.id
    subnetwork = google_compute_subnetwork.sub2.id

    access_config {
      
    }
    
  }

  
}

resource "google_compute_instance" "vm2" {
  name = "p2"
  zone = "us-west4-a"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      #image = "ubuntu-2404-lts-amd64"
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2504-plucky-amd64-v20250828"
    }
  }
  network_interface {
    network = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.sub1.id
    access_config {
      
    }
  }

}

