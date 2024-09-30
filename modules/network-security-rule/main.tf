resource "azurerm_network_security_rule" "nsg-nat-rule" {
    name = var.nat-rule-name
    priority = var.nat-rule-priority
    direction = var.nat-rule-direction
    access = var.nat-rule-access
    protocol = var.nat-rule-protocol
    source_port_range = var.nat-rule-source-port-range
    source_port_ranges = var.nat-rule-source-port-ranges
    destination_port_range = var.nat-rule-destination-port-range
    destination_port_ranges = var.nat-rule-destination-port-ranges
    source_address_prefix = var.nat-rule-source-address-prefix
    source_address_prefixes = var.nat-rule-source-address-prefixes
    destination_address_prefix = var.nat-rule-destination-address-prefix
    destination_address_prefixes = var.nat-rule-destination-address-prefixes
    resource_group_name = var.nat-rule-rg-name
    network_security_group_name = var.nat-rule-nsg-name
}