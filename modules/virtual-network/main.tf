resource "azurerm_virtual_network" "vnet" {
    name = var.vnet-name
    resource_group_name = var.vnet-rg-name
    location = var.vnet-rg-location
    address_space = var.vnet-address-space
}