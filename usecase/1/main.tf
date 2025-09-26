provider "google" {
   project = "venkat-473005"
   region  = "us-central1"

}


resource "google_compute_instance" "vm_instance" {
  name         = "example-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "venki:${file("./id_rsa.pub")}"
  }

  provisioner "file" {
    source      = "./text.txt"
    destination = "/home/venki/text.txt"
    connection {
      type        = "ssh"
      host        = self.network_interface[0].access_config[0].nat_ip
      user        = "venki"
      private_key = file("./id_rsa")
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io nginx",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
    connection {
      type        = "ssh"
      host        = self.network_interface[0].access_config[0].nat_ip
      user        = "venki"
      private_key = file("./id_rsa")
    }
  }
}