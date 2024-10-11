variable "firewall-policy-rule-collection-group-name" {
    description = "Firewall policy rule collection group name."
    type = string
}

variable "firewall-policy-id" {
    description = "Firewall policy ID."
    type = string
}

variable "firewall-policy-rule-collection-group-priority" {
    description = "Firewall policy rule collection group priority."
    type = number
}

# Application Rule Collection Variable - Dynamic Block
variable "application-rule-collection" {
    description = "A list of application rule collection."
    type = list(object({
        name = string
        priority = number
        action = string
        rule = list(object({
            name = string
            description = string
            protocols = list(object({
                type = string
                port = number
            }))
            http_headers = list(object({
                name = string
                value = string
            }))
            source_addresses = list(string)
            source_ip_groups = list(string)
            destination_addresses = list(string)
            destination_urls = list(string)
            destination_fqdns = list(string)
            destination_fqdn_tags = list(string)
            web_categories = list(string)
        }))
    }))
}