variable region {
  description = "The VPC region where the infrastructure will be deployed."
}

variable tags {
  default = ["ryantiffany"]
}


variable resource_group {
  description = "The name of the Resource group for deployed infrastructure."
}

variable project_name {
  description = "Label that will be used to identify resources in this deployment. Will also be assigned as a tag to any resource that supports it."
}