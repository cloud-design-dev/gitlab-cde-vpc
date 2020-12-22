variable resource_group {}
variable vpc_id {}
variable subnet_id {}

variable security_group_id {}

variable zone {}

variable ssh_keys {}
variable image_name {
  default = "ibm-ubuntu-20-04-minimal-amd64-2"
}
variable profile_name {
  default = "bx2-8x32"
}
variable tags {}
