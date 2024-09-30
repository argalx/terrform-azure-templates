output "nsg-output-id" {
    description = "NSG ID output value."
    value = azurerm_network_security_group.nsg.id
}

output "nsg-output-name" {
    description = "NSG Name output value."
    value = azurerm_network_security_group.nsg.name
}