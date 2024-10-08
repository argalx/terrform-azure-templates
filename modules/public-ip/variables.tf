variable "pip-name" {
    description = "Public IP name."
    type = string
}

variable "pip-rg-name" {
    description = "Public IP resource group name."
    type = string
}

variable "pip-location" {
    description = "Public IP resource group location."
    type = string
}

variable "pip-method" {
    description = "Public IP allocation method."
    type = string
}

variable "pip-sku" {
    description = "Public IP SKU."
    type = string
}