provider "azurerm" {
    features {

    }
}

# Test Resource Group for Terraform Azure Resources Scripts
resource "azurerm_resource_group" "agx-az-terraform-rg" {
    name = "agx-az-terraform-rg"
    location = "Australia East"
}

module "vnet-test" {
    source = "./modules/virtual-network"
    vnet-name = "test-vnet"
    vnet-rg-name = azurerm_resource_group.agx-az-terraform-rg.name
    vnet-rg-location = azurerm_resource_group.agx-az-terraform-rg.location
    vnet-address-space = ["10.0.0.0/16"]
    vnet-subnets = [
        {
            name = "subnet-test"
            address_prefixes = ["10.0.1.0/24"]
            security_group = module.nsg-test.nsg-output-id
            hasDelegation = true
            delegation_name = "testdelegation"
            service_delegation = [
                {
                    name = "Microsoft.ContainerInstance/containerGroups"
                    actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
                }
            ]
        },
        {
            name = "AzureFirewallSubnet"
            address_prefixes = ["10.0.2.0/24"]
            security_group = ""
            hasDelegation = false
            delegation_name = ""
            service_delegation = [
                {
                    name = ""
                    actions = []
                }
            ]
        }
    ]
}

module "nsg-test" {
    source = "./modules/network-security-group"
    nsg-name = "nsg-test"
    nsg-rg-name = azurerm_resource_group.agx-az-terraform-rg.name
    nsg-rg-location = azurerm_resource_group.agx-az-terraform-rg.location
    nsg-security-rules = [
        {
            name                        = "allow_management_inbound"
            priority                    = 106
            direction                   = "Inbound"
            access                      = "Allow"
            protocol                    = "Tcp"
            source_port_range           = "*"
            source_port_ranges          = []
            destination_port_range      = ""
            destination_port_ranges     = ["9000", "9003", "1438", "1440", "1452"]
            source_address_prefix       = "*"
            source_address_prefixes     = []
            destination_address_prefix  = "*"
            destination_address_prefixes = []
        },
        {
            name                        = "allow_misubnet_inbound"
            priority                    = 200
            direction                   = "Inbound"
            access                      = "Allow"
            protocol                    = "*"
            source_port_range           = "*"
            source_port_ranges          = []
            destination_port_range      = "*"
            destination_port_ranges     = []
            source_address_prefix       = "10.0.0.0/24"
            source_address_prefixes     = []
            destination_address_prefix  = "*"
            destination_address_prefixes = []
        }
    ]
}

# Public IP for Firewall
module "firewall-pip-test" {
    source = "./modules/public-ip"
    pip-name = "testpip"
    pip-rg-name = azurerm_resource_group.agx-az-terraform-rg.name
    pip-location = azurerm_resource_group.agx-az-terraform-rg.location
    pip-method = "Static"
    pip-sku = "Standard"
}

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

module "firewall-policy-test1" {
    source = "./modules/firewall-policy"
    firewall-policy-name = "test-policy1"
    firewall-rg-name = azurerm_resource_group.agx-az-terraform-rg.name
    firewall-policy-location = azurerm_resource_group.agx-az-terraform-rg.location
}

module "firewall-policy-rule-collection1" {
    source = "./modules/firewall-policy-rule-collection-group"
    firewall-policy-rule-collection-group-name = "fwpolicy1"
    firewall-policy-id = module.firewall-policy-test1.firewall-policy-id
    firewall-policy-rule-collection-group-priority = 500
    application-rule-collection = [
        {
            name = "app_rule_collection1"
            priority = 500
            action = "Deny"
            rule = [
                {
                    name = "app_rule_collection1_rule1"
                    description = "Sample Application Rule Collection"
                    protocols = [
                        {
                            type = "Http"
                            port = 80
                        },
                        {
                            type = "Https"
                            port = 443
                        }
                    ]
                    http_headers = [
                        {
                            name = "*"
                            value = "*"
                        }
                    ]
                    source_addresses = ["10.0.0.1"]
                    source_ip_groups = []
                    destination_addresses = []
                    destination_urls = []
                    destination_fqdns = ["*.microsoft.com"]
                    destination_fqdn_tags = []
                    web_categories = []
                }
            ]
        }
    ]
}