resource "azurerm_network_security_group" "nsg" {
    name = var.nsg-name
    resource_group_name = var.nsg-rg-name
    location = var.nsg-rg-location

    # Security Rule
    dynamic "security_rule" {
        for_each = var.nsg-security-rule
        content {
            name = nat-rule.value.name
            priority = nat-rule.value.priority
            direction = nat-rule.value.direction
            access = nat-rule.value.access
            protocol = nat-rule.value.protocol
            source_port_ranges = nat-rule.value.source_port_ranges
            destination_port_ranges = nat-rule.value.destination_port_ranges
            source_address_prefixes = nat-rule.value.source_address_prefixes
            destination_address_prefixes = nat-rule.value.destination_address_prefixes
        }
    }

    tags = {
    }
}