data "ibm_cis_domain" "cis_instance_domain" {
  domain = "cde-lab.cloud"
  cis_id = data.ibm_cis.cis_instance.id
}