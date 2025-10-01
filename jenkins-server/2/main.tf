provider "google" {
    project = "venkat-473005"
  
}

resource "google_compute_network" "vpc_network" {
    name                    = "my-vpc-network"
    auto_create_subnetworks = false
  
}
resource "google_compute_subnetwork" "subnet" {
    name          = "my-subnet"
    ip_cidr_range = "10.12.0.0/24"
    region        = "us-central1"
    network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow34" {
    name    = "allow-ssh"
    network = google_compute_network.vpc_network.name

    allow {
        protocol = "all"
    }

    source_ranges = ["0.0.0.0/0"]
  
}
resource "tls_private_key" "jenkins-keys" {
    algorithm = "RSA"
    rsa_bits = "4096"
}
resource "local_file" "jenki" {
    content = tls_private_key.jenkins-keys.private_key_pem
    filename = "${path.module}/id_rsa"
}
resource "local_file" "jenkpi" {
    content = tls_private_key.jenkins-keys.public_key_openssh
    filename = "${path.module}/id_rsa.pub"
}
locals {
  instances = {
    jenkins-master = {
        script = "./jenkins-master.sh"
    }
    jenkins-slave = {
        script = "./jenkins-slave.sh"

    }
  }
}

resource "google_compute_instance" "vm" {
    for_each = local.instances
    name         = each.key
    machine_type = "e2-medium"
    zone         = "us-central1-a"
    
    boot_disk {
        initialize_params {
        image = "projects/ubuntu-os-cloud/global/images/ubuntu-2504-plucky-amd64-v20250916"
        }
    }
    
    network_interface {
        network    = google_compute_network.vpc_network.id
        subnetwork = google_compute_subnetwork.subnet.id
    
        access_config {
        }
    }
    
    metadata = {
        ssh-keys = "admin:${tls_private_key.jenkins-keys.public_key_openssh}"
    }
    connection {
      type = "ssh"
      user = "admin"
      host = self.network_interface[0].access_config[0].nat_ip
      private_key = file(tls_private_key.jenkins-keys.private_key_pem)
    }
    metadata_startup_script = file(each.value.script)
    # provisioner "remote-exec" {
    #     inline = [  
    #         each.key == "jenkins-slave" ? "mkdir -p /home/venki/jenkins" : "echo 'not an slave vm'"
    #     ]
      
    # }
    provisioner "remote-exec" {
        inline = [
            "sudo cat /var/lib/jenkins/secrets/initialAdminPassword > /tmp/pass.txt",
            "sudo cat /tmp/pass.txt"
        ]        
        connection {
            type = "ssh"
            user = "admin"
            host = self.network_interface[0].access_config[0].nat_ip
            private_key = file(tls_private_key.jenkins-keys.private_key_pem)

        }
    }

     

}