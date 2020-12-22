data "ibm_cis_domain" "cis_instance_domain" {
  domain = "cde-lab.cloud"
  cis_id = var.cis_instance
}