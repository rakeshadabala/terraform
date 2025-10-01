provider "google" {
  project = "venkat-473005"
  
}

resource "google_service_account" "my_sa" {
  account_id   = "terraform-sa"
  display_name = "Terraform Service Account"
}

resource "google_project_iam_member" "sa_storage" {
    project = "venkat-473005"
    role = "roles/storage.admin"
    member = "serviceAccount:${google_service_account.my_sa.email}"
    depends_on = [ google_service_account.my_sa ]
  
}

resource "google_compute_instance" "vm-1" {
    name = "vm-1"
    machine_type = "e2-medium"
    zone = "us-central1-a"
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    } 
    network_interface {
      network = "default"
      access_config {
      }
    } 
    service_account {
      email = google_service_account.my_sa.email
      scopes = ["cloud-platform"]
    }
    
}