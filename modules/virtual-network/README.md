# Virtual Network Module

# Required azurerm Resource/Module

- azurerm_resource_group @ main.tf
- azurerm_network_security_group @ Modules for Subnet

# Module Properties

```
module "<module_name>" {
    source = <string> - Required
    vnet-name = <string> - Required
    vnet-rg-name = <string> - Required
    vnet-rg-location = <string> - Required
    vnet-address-space = <list(string)> - Required
    vnet-subnets = [
        {
            name = <string> - Required
            address_prefixes = <list(string)> - Required
            security_group = <string> - Required
            hasDelegation = <bool> - Optional
            delegation_name = <string> - Required if hasDelegation = true
            service_delegation = [
                {
                    name = <string> - Required if hasDelegation = true
                    actions = <list(string)> - Required if hasDelegation = true
                }
            ]
        }
    ]
}
```

# SAMPLE

```
module "vnet-test" {
    source = "./modules/virtual-network"
    vnet-name = "test-vnet"
    vnet-rg-name = azurerm_resource_group.agx-az-terraform-rg.name
    vnet-rg-location = azurerm_resource_group.agx-az-terraform-rg.location
    vnet-address-space = ["10.0.0.0/16"]
    vnet-subnets = [
        {
            name = "subnet-test"
            address_prefixes = ["10.0.1.0/24"]
            security_group = module.nsg-test.nsg-output-id
            hasDelegation = true
            delegation_name = "testdelegation"
            service_delegation = [
                {
                    name = "Microsoft.ContainerInstance/containerGroups"
                    actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
                }
            ]
        }
    ]
}
```
