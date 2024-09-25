variable "subnet-name" {
    description = "Subnet name."
    type = string
}

variable "subnet-rg-name" {
    description = "Subnet resource group name."
    type = string
}

variable "subnet-vnet-name" {
    description = "Subnet virtual network name."
    type = string
}

variable "subnet-address-prefixes" {
    description = "Subnet address prefixes."
    type = list(string)
}