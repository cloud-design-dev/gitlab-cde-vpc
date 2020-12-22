resource tls_private_key ssh {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource ibm_is_ssh_key generated_key {
  name           = "${var.project_name}-sshkey"
  public_key     = tls_private_key.ssh.public_key_openssh
  resource_group = var.resource_group
  tags           = concat(var.tags, ["type:is-ssh-key"])
}

resource "local_file" "ssh-key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "../ansible/generated_key_rsa"
  file_permission = "0600"
}


resource "ibm_is_vpc" "vpc" {
  name                      = "${var.project_name}-vpc"
  classic_access            = var.classic_access
  address_prefix_management = var.address_prefix_management
  resource_group            = var.resource_group
  tags                      = concat(var.tags, ["type:is-vpc"])
}

resource ibm_is_public_gateway gateway {
  name           = "${var.project_name}-${data.ibm_is_zones.mzr.zones[1]}-gateway"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[1]
  resource_group = var.resource_group
}

resource ibm_is_subnet service_subnet {
  name                     = "${var.project_name}-${data.ibm_is_zones.mzr.zones[1]}-service-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.mzr.zones[1]
  total_ipv4_address_count = var.address_count
  network_acl              = ibm_is_vpc.vpc.default_network_acl
  public_gateway           = ibm_is_public_gateway.gateway.id
  resource_group           = var.resource_group
}

resource ibm_is_subnet runner_subnet {
  name                     = "${var.project_name}-${data.ibm_is_zones.mzr.zones[1]}-runners-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.mzr.zones[1]
  total_ipv4_address_count = var.address_count
  network_acl              = ibm_is_vpc.vpc.default_network_acl
  public_gateway           = ibm_is_public_gateway.gateway.id
  resource_group           = var.resource_group
}


resource "ibm_is_security_group_rule" "default_https_in" {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}
