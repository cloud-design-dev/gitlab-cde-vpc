output domain_id {
  value = data.ibm_cis_domain.cis_instance_domain.id
}



# output ibm_certificate {
#    value = ibm_certificate_manager_order.gitlab_cert.certificate_details[*]
# }