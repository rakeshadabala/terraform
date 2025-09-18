#create vpc and subnet and vm
provider "google" {
    project = "peak-key-463905-i9"
  
}


# resource "google_compute_network" "vpc_network" {
#   name                    = "my-vpc-network"
#   auto_create_subnetworks = false
  
# }

# resource "google_compute_subnetwork" "subnet" {
#   name          = "my-subnet"
#   ip_cidr_range = "10.4.3.0/24"
#   region        = "us-west4"
#     network       = google_compute_network.vpc_network.id
# }

data "google_compute_network" "net" {
    name = "my-vpc-network"
  
}
data "google_compute_subnetwork" "subn" {
    name = "my-subnet"
    region = "us-west4"
  
}



//Create a VM instance in the specified subnet
resource "google_compute_instance" "vm_instance" {
    name         = "my-vm-instance"
    machine_type = "e2-medium"
    zone         = "us-west4-a"
    
    boot_disk {
        initialize_params {
        image = "debian-cloud/debian-11"
        }
    }
    
    network_interface {
        network = data.google_compute_network.net.self_link
        subnetwork = data.google_compute_subnetwork.subn.self_link
    
        access_config {
        // Ephemeral public IP
        }
    }
    }
    