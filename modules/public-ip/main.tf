resource "azurerm_public_ip" "pip" {
    name = var.pip-name
    resource_group_name = var.pip-rg-name
    location = var.pip-location
    allocation_method = var.pip-method
    sku = var.pip-sku
}