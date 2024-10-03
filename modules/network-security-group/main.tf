# NSG Resource
resource "azurerm_network_security_group" "nsg" {
    name = var.nsg-name
    resource_group_name = var.nsg-rg-name
    location = var.nsg-rg-location

    # Dynamic Security Rule
    dynamic "security_rule" {
        for_each = var.nsg-security-rules
        content {
            name = security_rule.value.name
            priority = security_rule.value.priority
            direction = security_rule.value.direction
            access = security_rule.value.access
            protocol = security_rule.value.protocol
            source_port_range = security_rule.value.source_port_range
            source_port_ranges = security_rule.value.source_port_ranges
            destination_port_range = security_rule.value.destination_port_range
            destination_port_ranges = security_rule.value.destination_port_ranges
            source_address_prefix = security_rule.value.source_address_prefix
            source_address_prefixes = security_rule.value.source_address_prefixes
            destination_address_prefix = security_rule.value.destination_address_prefix
            destination_address_prefixes = security_rule.value.destination_address_prefixes
        }
    }

    tags = {
    }
}

# Subnet NSG Assoc Resource
resource "azurerm_subnet_network_security_group_association" "subnet-nsg-assoc" {
    subnet_id = var.subnet-id
    network_security_group_id = azurerm_network_security_group.nsg.id
}