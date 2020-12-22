variable classic_access {
  description = "Specify if you want to create a VPC that can connect to classic infrastructure resources. Default is false."
  default     = false
}

variable address_prefix_management {
  description = "Indicates whether a default address prefix should be created automatically (auto) or manually (manual) for each zone in this VPC. Default value is auto."
  type        = string
  default     = "auto"
}

variable project_name {}

variable region {}

variable resource_group {}

variable tags {}

variable address_count {
  default = "128"
}

