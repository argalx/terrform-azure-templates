resource "azurerm_network_security_group" "nsg" {
    name = var.nsg-name
    resource_group_name = var.nsg-rg-name
    location = var.nsg-rg-location

    # Inline Network Security Rule

    # security_rule = {
    #     name = "test123"
    #     priority = 100
    #     direction = "Inbound"
    #     access = "Allow"
    #     protocol = "Tcp"
    #     source_port_range = "*"
    #     destination_port_range = "*"
    #     source_address_prefix = "*"
    #     destination_address_prefix = "*"
    # }

    tags = {
    }
}