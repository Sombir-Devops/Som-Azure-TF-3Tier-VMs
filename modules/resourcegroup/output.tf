output "resource_group_name" {
    value = azurerm_resource_group.Som-Azure-TF-3Tier-VMs.name
    description = "Name of the resource group"
}

output "location_id" {
    value = azurerm_resource_group.Som-Azure-TF-3Tier-VMs.location
    description = "Location id of the resource group"
}
