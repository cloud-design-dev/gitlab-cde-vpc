data ibm_resource_group group {
  name = var.resource_group
}



data "ibm_is_ssh_key" "ssh_key" {
  name = var.regional_ssh_key
}

