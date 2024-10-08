# Public IP Module

# Required azurerm Resource/Module

- N/A

# Module Properties

```
module "<module_name>" {
    source = <string> - Required
    pip-name = <string> - Required
    pip-rg-name = <string> - Required
    pip-location = <string> - Required
    pip-method = <string> - Required, options (Static, Dynamic)
    pip-sku = <string> - Required, options (Basic, Standard)
}
```

# SAMPLE

```
module "firewall-pip-test" {
    source = "./modules/public-ip"
    pip-name = "testpip"
    pip-rg-name = azurerm_resource_group.agx-az-terraform-rg.name
    pip-location = azurerm_resource_group.agx-az-terraform-rg.location
    pip-method = "Static"
    pip-sku = "Standard"
}
```
