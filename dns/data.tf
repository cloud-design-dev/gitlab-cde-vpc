data "ibm_cis" "cis_instance" {
  resource_group_id = var.resource_group
  name              = "cde-lab-cloud-cis"
}

data "ibm_resource_instance" "certificate_manager" {
  resource_group_id = var.resource_group
  name              = "cert-manager-rt"
  location          = "us-south"
  service           = "cloudcerts"
}

data "ibm_cis_domain" "cis_instance_domain" {
  domain = "cde-lab.cloud"
  cis_id = data.ibm_cis.cis_instance.id
}