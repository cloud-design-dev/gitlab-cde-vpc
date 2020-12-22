output cis_instance {
  value = data.ibm_cis.cis_instance.id
}

output certificate_manager_instance {
  value = data.ibm_resource_instance.certificate_manager.id
}

output regional_ssh_key_id {
  value = data.ibm_is_ssh_key.ssh_key.id
}