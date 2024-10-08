# Firewall Module

# Required azurerm Resource/Module

- azurerm_resource_group @ main.tf
- azurerm_public_ip @ Module
- azurerm_subnet @ v-net, Required Subnet Name: AzureFirewallSubnet
- azurerm_subnet @ data, To map existing subnet to Firewall

# Module Properties

```
# Get AzureFirewallSubnet information from VNET
data "azurerm_subnet" "<data_name>" {
    name = <string> - Required, Name of the subnet
    virtual_network_name = <string> - Required
    resource_group_name = <string> - Required
}

module "<module_name>" {
    source =  <string> - Required
    # Firewall Resource
    firewall-name =  <string> - Required
    firewall-rg-name =  <string> - Required
    firewall-location =  <string> - Required
    firewall-sku-name =  <string> - Required, Options (AZFW_Hub, AZFW_VNet)
    firewall-sku-tier = <string> - Required, Options (Premium, Standard, Basic)

    # IP Confiugration
    firewall-ip-config = [
        {
            name = <string> - Required
            subnet_id = <string> - Required
            public_ip_address_id = <string> - Required
        }
    ]
}
```

# SAMPLE

```
# Get AzureFirewallSubnet information from VNET
data "azurerm_subnet" "azfirewallsubnet" {
    name = "AzureFirewallSubnet"
    virtual_network_name = module.vnet-test.vnet-output-name
    resource_group_name = azurerm_resource_group.agx-az-terraform-rg.name
}

module "firewall-test" {
    source = "./modules/firewall"
    # Firewall Resource
    firewall-name = "testfirewall"
    firewall-rg-name = azurerm_resource_group.agx-az-terraform-rg.name
    firewall-location = azurerm_resource_group.agx-az-terraform-rg.location
    firewall-sku-name = "AZFW_VNet"
    firewall-sku-tier = "Standard"

    # IP Confiugration
    firewall-ip-config = [
        {
            name = "firewallIpConfig1"
            subnet_id = data.azurerm_subnet.azfirewallsubnet.id
            public_ip_address_id = module.firewall-pip-test.pip-output-id
        }
    ]
}
```
