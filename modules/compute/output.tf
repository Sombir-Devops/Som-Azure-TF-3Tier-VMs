output "webvmname" {
  value = azurerm_virtual_machine.web-vm.name
  description = "Name of the VM in web subnet"
}

output "Appvmname" {
  value = azurerm_virtual_machine.app-vm.name
  description = "Name of the VM in App subnet"
}


