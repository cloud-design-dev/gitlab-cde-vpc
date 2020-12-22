output domain_id {
  value = data.ibm_cis_domain.cis_instance_domain.id
}

output certificate_manager {
  value = data.ibm_resource_instance.certificate_manager.id
}

output cis_instance {
  value = data.ibm_cis.cis_instance.id
}

# output ibm_certificate {
#   value = ibm_certificate_manager_order.gitlab_cert.certificate_details
# }