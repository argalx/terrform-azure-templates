# Firewall Policy Module

# Required azurerm Resource/Module

- azurerm_resource_group @ main.tf

# Module Properties

```
module "<module_name>" {
    source = <string> - Required
    firewall-policy-name = <string> - Required
    firewall-rg-name = <string> - Required
    firewall-policy-location = <string> - Required
}
```

# SAMPLE

```
module "firewall-policy-test1" {
    source = "./modules/firewall-policy"
    firewall-policy-name = "test-policy1"
    firewall-rg-name = azurerm_resource_group.agx-az-terraform-rg.name
    firewall-policy-location = azurerm_resource_group.agx-az-terraform-rg.location
}
```
