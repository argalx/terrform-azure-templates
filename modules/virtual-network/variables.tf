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

# Dynamic Subnet and Delegation Assignment
variable "vnet-subnets" {
    description = "A list of subnets."
    type = list(object({
        name = string
        address_prefixes = list(string)
        security_group = string
        hasDelegation = bool
        delegation_name = string
        service_delegation = list(object({
          name = string
          actions = list(string)
        }))
    }))
}