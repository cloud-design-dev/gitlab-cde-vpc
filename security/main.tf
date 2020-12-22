resource "ibm_is_security_group" "project_security_group" {
  name           = "runner-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group
}

resource "ibm_is_security_group_rule" "all_outbound" {
  group     = ibm_is_security_group.project_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_security_group_rule" "ssh_in_from_services" {
  group     = ibm_is_security_group.project_security_group.id
  direction = "inbound"
  remote    = var.service_subnet
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "https_in" {
  group     = ibm_is_security_group.project_security_group.id
  direction = "inbound"
  remote    = var.service_subnet
  tcp {
    port_min = 443
    port_max = 443
  }
}


