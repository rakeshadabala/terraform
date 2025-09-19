output "jenkins-master-ip" {
    value = "https:${google_compute_instance.vm["jenkins-master"].network_interface[0].access_config[0].nat_ip}:8080"
  
}
output "jenkins-slave-ip" {
    value = "https:${google_compute_instance.vm["jenkins-slave"].network_interface[0].access_config[0].nat_ip}:8080"
  
}