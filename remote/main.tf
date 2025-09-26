provider "google" {
    project = "venkat-473005"
    region = "us-central1"
  
}

module "network" {
    source = "git::https://github.com/venkat-6666/terraform.git//modules(tf)//vpc?ref=main"
    vpcname = "venki-vpc"
    vpcset = false
}

module "subnet" {
    source = "git::https://github.com/venkat-6666/terraform.git//modules(tf)//subnet?ref=main"
    vpc-sub-name = "subnet-a"
    region-sub = "us-central1"
    sub-network = "venki-vpc"
    sub-ip = "10.0.0.0/8"
    depends_on = [ module.network ]
}

module "vm" {
    source = "git::https://github.com/venkat-6666/terraform.git//modules(tf)//gce?ref=main"

    name = "mrvm"
    zone = "us-central1-a"
    machine_type = "e2-medium"
    image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    network = "venki-vpc"
    subnetwork = "subnet-a"

    depends_on = [ module.network,module.subnet ]
}

#  -reconfigure 
#  -migrate-state