resource "azurerm_virtual_network" "vnet" {
    name = var.vnet-name
    resource_group_name = var.vnet-rg-name
    location = var.vnet-rg-location
    address_space = var.vnet-address-space

    dynamic "subnet" {
        for_each = var.vnet-subnets
        content {
            name = subnet.value.name
            address_prefixes = subnet.value.address_prefixes
            security_group = subnet.value.security_group
        }
    }
}