# Azure network resources

## Introduction

This module manages required Azure network resources.

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "azure-network" {
  source = "dodevops/network/azure"
  version = "<version>"
  
  (...)
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

The following providers are used by this module:

- azurerm

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_network_security_group.network-security-group-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) (resource)
- [azurerm_network_security_rule.network-security-rules-inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) (resource)
- [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) (resource)
- [azurerm_subnet_network_security_group_association.nsgassociation-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) (resource)
- [azurerm_virtual_network.virtual-network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [azurerm_virtual_network_peering.network-peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) (resource)

## Required Inputs

The following input variables are required:

### location

Description: The azure location used for azure

Type: `string`

### network\_cidr

Description: The address space to use for the complete network

Type: `string`

### project

Description: Three letter project key

Type: `string`

### resource\_group

Description: Azure Resource Group to use

Type: `string`

### stage

Description: Stage for this ressource group

Type: `string`

### subnets

Description: A map of subnets (with a map of rules for each subnet to apply to the network security group of the virtual network for each of the subnets)

Type:

```hcl
map(object({
    cidr                                           = list(string)
    service_endpoints                              = list(string)
    enforce_private_link_endpoint_network_policies = bool
    rules = map(object({
      priority                     = number,
      source_address_prefixes      = list(string),
      source_port_ranges           = list(string),
      destination_address_prefixes = list(string),
      destination_port_ranges      = list(string),
      protocol                     = string,
    }))
  }))
```

## Optional Inputs

The following input variables are optional (have default values):

### peering\_remote\_virtual\_network\_id

Description: The id of the remote virtual network to peer to, if required

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### network

Description: The created network resource

### subnet\_ids

Description: Map of the created subnet ids
<!-- END_TF_DOCS -->

## Development

Use [terraform-docs](https://terraform-docs.io/) to generate the API documentation by running

    terraform fmt .
    terraform-docs .
