# resource "ibm_certificate_manager_order" "gitlab_cert" {
#   certificate_manager_instance_id = data.ibm_resource_instance.certificate_manager.id
#   name                            = "gitlab-certificate"
#   description                     = "Certificate for gitlab vpc instance"
#   domains                         = ["gitlab.cde-lab.cloud"]
#   rotate_keys                     = false
#   domain_validation_method        = "dns-01"
#   dns_provider_instance_crn       = data.ibm_cis.cis_instance.id
# }



# Add a DNS record to the domain
resource "ibm_cis_dns_record" "gitlab" {
  cis_id    = data.ibm_cis.cis_instance.id
  domain_id = data.ibm_cis_domain.cis_instance_domain.id
  name      = "gitlab"
  content   = var.gitlab_ip
  type      = "A"
}

