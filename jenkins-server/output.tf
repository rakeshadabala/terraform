# output "name" {
#     value = google_compute_instance.tf_vm.name
#     description = "The name of the VM instance"
  
# }
# output "ip" {
#     value = google_compute_instance.tf_vm.network_interface[0].access_config[0].nat_ip
#     description = "The public IP address of the VM instance"
  
# }


output "ip" {
  value = { for k, v in google_compute_instance.tf_vm : k => v.network_interface[0].access_config[0].nat_ip }
  description = "The public IP addresses of the VM instances"
}
