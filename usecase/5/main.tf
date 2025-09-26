provider "google" {
   project = "venkat-473005"
   region  = "us-central1"

}

resource "google_compute_instance" "vm" {
    name = "vm-1"
    machine_type = "e2-medium"
    zone = "us-central1-a"
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      }
    }
    network_interface {
      network = "default"
      access_config {
        
      }
    }
    metadata = {
        ssh-keys = "venki:${file("C:/Users/venka/OneDrive/Documents/terraform/usecase/5/gcpkey.pub")}"

    }

 provisioner "file" {
  source = "Dockerfile.txt"
  destination = "/home/venki/Dockerfile"

  connection {
    type        = "ssh"
    user        = "venki"
    private_key = file("C:/Users/venka/OneDrive/Documents/terraform/usecase/5/gcpkey")
    host        = self.network_interface[0].access_config[0].nat_ip
    
  }
   
 }

 provisioner "file" { 
    source = "startup.sh"
    destination = "/home/venki/startup.sh"
   
    connection {
      type        = "ssh"
      user        = "venki"
      private_key = file("C:/Users/venka/OneDrive/Documents/terraform/usecase/5/gcpkey")
      host        = self.network_interface[0].access_config[0].nat_ip
    }
 }
 provisioner "remote-exec" {
  inline = [  
     "sudo chmod +x /home/venki/startup.sh",
     "sudo /home/venki/startup.sh"
   ]

       connection {
      type        = "ssh"
      user        = "venki"
      private_key = file("C:/Users/venka/OneDrive/Documents/terraform/usecase/5/gcpkey")
      host        = self.network_interface[0].access_config[0].nat_ip
    }
   
 }


}