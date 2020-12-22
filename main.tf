locals {
  name = formatdate("DDhhmm", timestamp())
}

module environment {
  source                       = "./environment"
  resource_group               = data.ibm_resource_group.group.id
  certificate_manager_instance = var.certificate_manager_instance
  cis_instance                 = var.cis_instance
  regional_ssh_key             = var.regional_ssh_key
}

module vpc {
  source         = "./vpc"
  project_name   = var.project_name
  resource_group = data.ibm_resource_group.group.id
  region         = var.region
  tags           = concat(var.tags, ["region:${var.region}", "project_version:${local.name}", "terraform_workspace:${terraform.workspace}"])
}

module security {
  source         = "./security"
  project_name   = var.project_name
  resource_group = data.ibm_resource_group.group.id
  vpc_id         = module.vpc.vpc.id
  service_subnet = module.vpc.service_subnet.ipv4_cidr_block
}

module gitlab {
  source            = "./instance"
  resource_group    = data.ibm_resource_group.group.id
  vpc_id            = module.vpc.vpc.id
  subnet_id         = module.vpc.service_subnet.id
  security_group_id = module.vpc.vpc.default_security_group
  zone              = module.vpc.zone
  ssh_keys          = [module.vpc.generated_key_id, module.environment.regional_ssh_key_id]
  tags              = concat(var.tags, ["region:${var.region}", "project_version:${local.name}", "terraform_workspace:${terraform.workspace}"])
}

module dns {
  depends_on                   = [module.gitlab]
  source                       = "./dns"
  gitlab_ip                    = module.gitlab.gitlab_ip
  resource_group               = data.ibm_resource_group.group.id
  cis_instance                 = module.environment.cis_instance
  certificate_manager_instance = module.environment.certificate_manager_instance
}

# module ansible {
#   source       = "./ansible"
#   gitlab_ip    = module.gitlab.gitlab_ip
# }
