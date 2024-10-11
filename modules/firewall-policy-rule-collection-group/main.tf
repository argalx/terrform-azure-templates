resource "azurerm_firewall_policy_rule_collection_group" "firewall-policy-rule-collection" {
    name = var.firewall-policy-rule-collection-group-name
    firewall_policy_id = var.firewall-policy-id
    priority = var.firewall-policy-rule-collection-group-priority

    # Application Rule Collection
    dynamic "application_rule_collection" {
        for_each = var.application-rule-collection
        content {
            name = application_rule_collection.value.name
            priority = application_rule_collection.value.priority
            action = application_rule_collection.value.action
            
            dynamic "rule" {
                for_each = application_rule_collection.value.rule
                content {
                    name = rule.value.name
                    description = rule.value.description
                    
                    dynamic "protocols" {
                        for_each = rule.value.protocols
                        content {
                            type = protocols.value.type
                            port = protocols.value.port
                        }
                    }

                    dynamic "http_headers" {
                        for_each = rule.value.http_headers
                        content {
                            name = http_headers.value.name
                            value = http_headers.value.value
                        }
                    }

                    source_addresses = rule.value.source_addresses
                    source_ip_groups = rule.value.source_ip_groups
                    destination_addresses = rule.value.destination_addresses
                    destination_urls = rule.value.destination_urls
                    destination_fqdns = rule.value.destination_fqdns
                    destination_fqdn_tags = rule.value.destination_fqdn_tags
                    web_categories = rule.value.web_categories
                }
            }
        }
    }

    # Network Rule Collection


    # NAT Rule Collection


}