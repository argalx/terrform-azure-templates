resource "azurerm_firewall_policy" "firewall-policy" {
    name = var.firewall-policy-name
    resource_group_name = var.firewall-rg-name
    location = var.firewall-policy-location
}