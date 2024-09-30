# START OF REQUIRED
variable "nat-rule-name" {
    description = "Network security rule name."
    type = string
}

variable "nat-rule-priority" {
    description = "Network security rule priority."
    # Option - 100 to 4096
    type = number
}

variable "nat-rule-direction" {
    description = "Network security rule direction."
    # Option - Inbound, Outbound
    type = string
}

variable "nat-rule-access" {
    description = "Network security rule access."
    # Option - Allow, Deny
    type = string
}

variable "nat-rule-rg-name" {
    description = "Network security rule resource group name."
    type = string
}

variable "nat-rule-nsg-name" {
    description = "Network security group name."
    type = string
}

variable "nat-rule-protocol" {
    description = "Network security rule protocol."
    # Options - Tcp, Udp, Icmp, Esp, Ah, *
    type = string
}
# END OF REQUIRED

# START OF OPTIONAL

# Source Port Range
variable "nat-rule-source-port-range" {
    default = ""
    type = string
}

variable "nat-rule-source-port-ranges" {
    default = [ "" ]
    type = list(string)
}

# Destination Port range
variable "nat-rule-destination-port-range" {
    default = ""
    type = string
}

variable "nat-rule-destination-port-ranges" {
    default = [ "" ]
    type = list(string)
}

# Source Address Prefix
variable "nat-rule-source-address-prefix" {
    default = ""
    type = string
}

variable "nat-rule-source-address-prefixes" {
    default = [ "" ]
    type = list(string)
}

# Destination Address Prefix
variable "nat-rule-destination-address-prefix" {
    default = ""
    type = string
}

variable "nat-rule-destination-address-prefixes" {
    default = [ "" ]
    type = list(string)
}