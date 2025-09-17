provider "google"{
    project = "peak-key-463905-i9"
    region  = "us-central1"
}



resource "google_compute_instance" "vm_instance" {
  name         = "vm-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "venki:${file("./venki.pub")}"
  }

  provisioner "file" {
    source      = "abc"
    destination = "/home/venki/abc"

    connection {
      type        = "ssh"
      user        = "venki"
      private_key = file("./venki")
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }
}
