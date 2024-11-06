resource "null_resource" "linux_provisioner" {
  for_each = azurerm_linux_virtual_machine.n01580095-vm

  provisioner "remote-exec" {
    inline = [
      "hostname"
    ]

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file(var.priv_key)
      host        = azurerm_linux_virtual_machine.n01580095-vm[each.key].public_ip_address
    }
  }
}

