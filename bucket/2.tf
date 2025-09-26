# resource "google_compute_network" "vpc" {
#   name                    = "cos-vpc"
#   auto_create_subnetworks = false

# }

# resource "google_compute_subnetwork" "subnet" {
#   name          = "subnet-1"
#   network       = google_compute_network.vpc.id
#   ip_cidr_range = "10.12.0.0/24"
# }

# resource "google_compute_firewall" "firewall-1" {
#     name = ""
#     network = google_compute_network.vpc.id
#     allow {
#       protocol = "tcp"
#       ports = ["22","80"]
#     }
#     direction = 
  
# }


# resource "google_compute_instance" "vm-2" {
#   name         = "vm"
#   zone         = "us-central1-a"
#   machine_type = "e2-medium"
#   boot_disk {
#     initialize_params {
#       image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
#     }
#   }
#   network_interface {
#     network    = google_compute_network.vpc.id
#     subnetwork = google_compute_subnetwork.subnet.id
#     access_config {

#     }

#   }
#   metadata = {
#     ssh-keys = "admin:${file("./venki.pub")}"
#     #startup_script = file("./5.sh")
#   }



#   provisioner "file" {
#     source      = "./Dockerfile.dockerfile"
#     destination = "/home/admin/Dockerfile.dockerfile"

#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update -y",
#       "sudo apt install docker.io -y",
#       "sudo systemctl start docker",
#       "sudo systemctl enable docker",
#       "sudo apt install nginx -y",
#     ]

#   }
#     connection {
#     type        = "ssh"
#     private_key = file("./venki")
#     host        = self.network_interface[0].access_config[0].nat_ip
#     user        = "admin"

#   }

# }