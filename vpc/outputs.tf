output vpc {
  value = ibm_is_vpc.vpc
}

output runner_subnet {
  value = ibm_is_subnet.runner_subnet
}

output service_subnet {
  value = ibm_is_subnet.service_subnet
}

output generated_key_id {
  value = ibm_is_ssh_key.generated_key.id
}

output zone {
  value = data.ibm_is_zones.mzr.zones[1]
}
