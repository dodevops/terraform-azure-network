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

- [azurerm_network_security_group.network-security-group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) (resource)
- [azurerm_network_security_rule.network-security-rules-inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) (resource)
- [azurerm_subnet.default-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) (resource)
- [azurerm_subnet.gateway-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) (resource)
- [azurerm_subnet_network_security_group_association.network-security-group-association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) (resource)
- [azurerm_virtual_network.virtual-network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [azurerm_virtual_network_peering.network-peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) (resource)

## Required Inputs

The following input variables are required:

### default\_subnet\_cidr

Description: CIDR of the default subnet

Type: `string`

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

### rules

Description: A map of firewall rules to apply to the network security group of the virtual network

Type:

```hcl
map(object({
    priority                     = number,
    source_address_prefixes      = list(string),
    source_port_ranges           = list(string),
    destination_address_prefixes = list(string),
    destination_port_ranges      = list(string),
    protocol                     = string,
  }))
```

### stage

Description: Stage for this ressource group

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### gateway\_subnet\_cidr

Description: CIDR of the gateway subnet. If not specified, Subnet Gateway will not be created

Type: `string`

Default: `"NONE"`

### peering\_remote\_virtual\_network\_id

Description: The id of the remote virtual network to peer to, if required

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### default\_subnet\_id

Description: The id of the default subnet

### gateway\_subnet\_id

Description: The id of the gateway subnet

### network\_id

Description: The id of the virtual network

### network\_name

Description: The name of the virtual network
<!-- END_TF_DOCS -->

## Development

Use [terraform-docs](https://terraform-docs.io/) to generate the API documentation by running

    terraform fmt .
    terraform-docs .
