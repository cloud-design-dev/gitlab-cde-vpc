output instance_ip {
  value = ibm_is_instance.instance.primary_network_interface[0].primary_ipv4_address
}

output primary_network_interface {
  value = ibm_is_instance.instance.primary_network_interface[0].id
}

output gitlab_ip {
  value = ibm_is_floating_ip.gitlab.address
}