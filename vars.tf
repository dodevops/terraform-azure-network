variable "location" {
  type        = string
  description = "The azure location used for azure"
}

variable "project" {
  type        = string
  description = "Three letter project key"
}

variable "stage" {
  type        = string
  description = "Stage for this ressource group"
}

variable "resource_group" {
  type        = string
  description = "Azure Resource Group to use"
}

variable "network_cidr" {
  type        = string
  description = "The address space to use for the complete network"
}

variable "peering_remote_virtual_network_id" {
  type        = string
  default     = ""
  description = "The id of the remote virtual network to peer to, if required"
}

variable "subnets" {
  type = map(object({
    cidr                                      = list(string)
    service_endpoints                         = list(string)
    private_endpoint_network_policies_enabled = bool
    rules = map(object({
      priority                     = number,
      source_address_prefixes      = list(string),
      source_port_ranges           = list(string),
      destination_address_prefixes = list(string),
      destination_port_ranges      = list(string),
      protocol                     = string,
    }))
  }))
  description = "A map of subnets (with a map of rules for each subnet to apply to the network security group of the virtual network for each of the subnets)"
}
