variable "firewall-name" {
    description = "Firewall name."
    type = string
}

variable "firewall-rg-name" {
    description = "Firewall resource group name."
    type = string
}

variable "firewall-location" {
    description = "Firewall resource group location."
    type = string
}

variable "firewall-sku-name" {
    description = "Firewall SKU name."
    type = string
}

variable "firewall-sku-tier" {
    description = "Firewall SKU tier."
    type = string
}

variable "firewall-ip-config" {
    description = "A list of Firewall IP configuration"
    type = list(object({
      name = string
      subnet_id = string
      public_ip_address_id = string
    }))
}