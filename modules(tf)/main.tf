
# provider "google" {
#     project = var.project
#     region = var.region
  
# }



module "vpc_mod" {
    source = "./vpc"
    vpcname = var.vpc_module_name
    vpcset = var.vpc_module_subnets
}

module "subnets" {
    source = "./subnet"
    sub-ip = var.subnet_ip
    sub-network = module.vpc_mod.vpc_out
    vpc-sub-name = var.subnet_name
    region-sub = var.subnet_region
    depends_on = [ module.vpc_mod ]
}

module "vpc" {
    source = "./vpc"
    vpcname = "venkat"
    vpcset = true
  
}

# resource "google_compute_network" "name" {
#     name = "new"
#     auto_create_subnetworks = true
  
#}

module "vm" {
    source = "./gce"
    project_id = var.project
    machine_type = var.machine
    zone = var.zoner
    region = var.region
    image = var.image
    network = module.subnets.sub-out
    name = var.vm_name
    depends_on = [ module.subnets,module.vpc_mod]
  
}



