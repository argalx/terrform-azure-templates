variable "vnet-name" {
    description = "Virtual network name."
    type = string
}

variable "vnet-rg-name" {
    description = "Virtual network resource group name."
    type = string
}

variable "vnet-rg-location" {
    description = "Virtual network resource group location."
    type = string
}

variable "vnet-address-space" {
    description = "Virtual network address space."
    type = list(string)
}