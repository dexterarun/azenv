output "nic" {
    value = azurerm_network_interface.vm
}

output "vm" {
    value = azurerm_linux_virtual_machine.vm
}