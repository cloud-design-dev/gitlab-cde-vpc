data ibm_is_image image {
  name = var.image_name
}
resource "ibm_is_instance" "instance" {
  name           = "gitlab"
  vpc            = var.vpc_id
  zone           = var.zone
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = var.ssh_keys
  resource_group = var.resource_group

  user_data = file("${path.module}/init.yml")

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = [var.security_group_id]
  }

  boot_volume {
    name = "gitlab-boot"
  }

  tags = concat(var.tags, [var.zone, "instance"])
}


resource ibm_is_floating_ip gitlab {
  name           = "gitlab-fip"
  target         = ibm_is_instance.instance.primary_network_interface[0].id
  resource_group = var.resource_group
}
