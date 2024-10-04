# Network Security Group Module

# Prerequisites

- azurerm_resource_group @ main.tf

# Module Properties

```
module "<module_name>" {
    source = <string> - Required
    nsg-name = <string> - Required
    nsg-rg-name = <string> - Required
    nsg-rg-location = <string> - Required
    nsg-security-rules = [
        {
            name                        = <string> - Required
            priority                    = <number> - Required
            direction                   = <string> - Required
            access                      = <string> - Required
            protocol                    = <string> - Required
            source_port_range           = <string> - Option (Must have default value if not in use: "")
            source_port_ranges          = <list(string)> - Option (Must have default value if not in use: [])
            destination_port_range      = <string> - Option (Must have default value if not in use: "")
            destination_port_ranges     = <list(string)> - Option (Must have default value if not in use: [])
            source_address_prefix       = <string> - Option (Must have default value if not in use: "")
            source_address_prefixes     = <list(string)> - Option (Must have default value if not in use: [])
            destination_address_prefix  = <string> - Option (Must have default value if not in use: "")
            destination_address_prefixes = <list(string)> - Option (Must have default value if not in use: [])
        }
    ]
}
```

# SAMPLE

```
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
```
