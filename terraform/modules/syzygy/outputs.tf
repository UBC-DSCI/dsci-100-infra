output "hub_ip" {
  value = "${libvirt_domain.hub.network_interface.0.addresses.0}"
}


output "mark_ip" {
  value = "${libvirt_domain.marking.network_interface.0.addresses.0}"
}
