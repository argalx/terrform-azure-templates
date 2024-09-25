resource "azurerm_subnet" "subnet" {
    name = var.subnet-name
    resource_group_name = var.subnet-rg-name
    virtual_network_name = var.subnet-vnet-name
    address_prefixes = var.subnet-address-prefixes

    # Delegation

    # delegation {
    #   name = "example-delegation"

    #   service_delegation {
    #     name = "Microsoft.ContainerInstance/containerGroups"
    #     actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    #   }
    # }
}