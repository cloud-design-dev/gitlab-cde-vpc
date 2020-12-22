resource "local_file" "ansible-inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl",
    {
      gitlab_ip  = var.gitlab_ip
      bastion_ip = var.bastion_ip
    }
  )
  filename = "${path.module}/inventory"
}

# resource "local_file" "ansible_inventory_vars" {
#   content = templatefile("${path.module}/templates/deployment_vars.tmpl",
#     {
#       encrypt_key = var.encrypt_key
#       region      = var.region
#     }
#   )
#   filename = "${path.module}/playbooks/deployment_vars.yml"
# }

resource "local_file" "ansible-config" {
  content = templatefile("${path.module}/templates/ansible.cfg.tmpl",
    {
      bastion_ip = var.bastion_ip
    }
  )
  filename = "${path.module}/ansible.cfg"
}

data "ibm_certificate_manager_certificate" "source_certificate" {
  certificate_manager_instance_id = var.cert_manager
  name                            = "gitlab-certificate"
}

# resource "local_file" "gitlab_cert" {
#   content         = data.ibm_certificate_manager_certificate.source_certificate.certificate_details.data.content
#   filename        = "../ansible/certificate-details.txt"
#   file_permission = "0600"
# }

# module runner_template {
#   source            = "./instance-template"
#   resource_group    = data.ibm_resource_group.group.id
#   vpc_id            = module.vpc.vpc.id
#   subnet_id         = module.vpc.runner_subnet.id
#   security_group_id = module.security.id
#   zone              = "${var.region}-1"
#   ssh_key           = module.vpc.ssh_key_id
#   tags              = concat(var.tags, ["region:${var.region}", "project_version:${local.name}", "terraform_workspace:${terraform.workspace}"])
# }