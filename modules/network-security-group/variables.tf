# NSG General Properties
variable "nsg-name" {
    description = "NSG name."
    type = string
}

variable "nsg-rg-name" {
    description = "NSG resource group name."
    type = string
}

variable "nsg-rg-location" {
    description = "NSG resource group location."
    type = string
}

# Security Rule Variable
variable "nsg-security-rule" {
    description = "A list of security rules for the NSG"
    type = list(object({
        name = string
        priority = number
        direction = string
        access = string
        protocol = string
        source_port_range = string
        source_port_ranges = list(string)
        destination_port_range = string
        destination_port_ranges = list(string)
        source_address_prefix = string
        source_address_prefixes = list(string)
        destination_address_prefix = string
        destination_address_prefixes = list(string)
    }))
}

# Subnet NSG Assoc Variable
variable "subnet-id" {
    description = "Subnet ID."
    type = string
}