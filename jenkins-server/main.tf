provider "google" {
    project = "peak-key-463905-i9"
  
}

resource "google_compute_network" "name" {
    name  = "my-network"
    auto_create_subnetworks = false
  
}

resource "google_compute_subnetwork" "subnet" {
    name          = "my-subnet"
    ip_cidr_range = "10.12.0.0/24"
    region        = "us-central1"
    network       = google_compute_network.name.id
}


resource "google_compute_firewall" "allow" {
    name    = "allow-ssh-http"
    network = google_compute_network.name.name

    allow {
        protocol = "tcp"
        ports    = ["22", "8080","80"]
    }

    source_ranges = ["0.0.0.0/0"]
  
}

locals {
  instances = {
    jenkins-master = {
        zone = "us-central1-a"
        machine = "e2-medium"
        tags = ["jenkins-master"]
    }
    jenkins-slave = {
        zone = "us-central1-f"
        machine = "e2-small"
        tags = ["jenkins-slave"]
    }
  }
}

resource "google_compute_instance" "tf_vm" {
    for_each = local.instances
    name = each.key
    zone = each.value.zone
    machine_type = each.value.machine
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      }
    }
    network_interface {
      network = google_compute_network.name.id
      subnetwork = google_compute_subnetwork.subnet.id
      access_config {
        
      }
    }
    metadata = {
      ssh-keys = "venki:${file("./venki.pub")}"
    }
    connection {
      type = "ssh"
      user = "venki"
      private_key = file("./venki")
      host = self.network_interface[0].access_config[0].nat_ip
    }
    metadata_startup_script = file("./startupscript.sh")


  
}
