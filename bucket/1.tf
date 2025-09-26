# # resource "google_compute_instance" "vm" {
# #     count = 2
# #     name = "vm-${count.index}"
# #     machine_type = "e2-medium"
# #     zone = "us-centarl1-a"
# #     boot_disk {
# #       initialize_params {
# #         image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
# #       }
# #     }
# #     network_interface {
# #       network = "default"
# #     }

# # }

# variable "vms" {
#     type = list(object({
#       name = string
#       machine_type = string
#       zone = string
#       image = string
#       network = string
#     }
#     )
#     )
#     default = [
#       {
#         name         = "vm-0"
#         machine_type = "e2-micro"
#         zone         = "us-west4"
#         image        = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
#         network      = "default"
#       },
#       {
#         name         = "vm-1"
#         machine_type = "e2-medium"
#         zone         = "us-central1-a"
#         image        = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
#         network      = "default"
#       }
#     ]

# }

# resource "google_compute_instance" "vms" {
#     count = length(var.vms)
#     name = var.vms[count.index].name
#     machine_type = var.vms[count.index].machine_type
#     zone = var.vms[count.index].zone
#     boot_disk {
#       initialize_params {
#         image = var.vms[count.index].image
#       }
#     }
#     network_interface {
#       network = var.vms[count.index].network
#     }



# }