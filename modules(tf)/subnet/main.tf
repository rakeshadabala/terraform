resource "google_compute_subnetwork" "vpc-sub" {
    name = var.vpc-sub-name
    region = var.region-sub
    network = var.sub-network
    ip_cidr_range = var.sub-ip
  
}

