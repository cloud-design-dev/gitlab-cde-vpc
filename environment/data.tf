data "ibm_cis" "cis_instance" {
  resource_group_id = var.resource_group
  name              = var.cis_instance
}

data "ibm_resource_instance" "certificate_manager" {
  resource_group_id = var.resource_group
  name              = var.certificate_manager_instance
  location          = "us-south"
  service           = "cloudcerts"
}

data "ibm_is_ssh_key" "ssh_key" {
  name = var.regional_ssh_key
}