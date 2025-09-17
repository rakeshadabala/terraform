

resource "google_compute_network" "vpcnet" {
    name = var.vpcname
    auto_create_subnetworks = var.vpcset
  
}

