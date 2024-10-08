resource "azurerm_firewall" "firewall" {
    name = var.firewall-name
    resource_group_name = var.firewall-rg-name
    location = var.firewall-location
    sku_name = var.firewall-sku-name
    sku_tier = var.firewall-sku-tier

    dynamic "ip_configuration" {
        for_each = var.firewall-ip-config
        content {
            name = ip_configuration.value.name
            subnet_id = ip_configuration.value.subnet_id
            public_ip_address_id = ip_configuration.value.public_ip_address_id
        }
    }
}