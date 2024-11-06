resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  tags                = local.common_tags
}

resource "azurerm_lb" "loadbalancer" {
  name  = var.loadbalancer_name
  location  = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
  tags                = local.common_tags
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name            = "backendPool"
  loadbalancer_id = azurerm_lb.loadbalancer.id
}

resource "azurerm_lb_probe" "lb_probe" {
  name            = "tcpProbe"
  loadbalancer_id = azurerm_lb.loadbalancer.id
  port            = 80
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "httpRule"
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  frontend_ip_configuration_name = azurerm_lb.loadbalancer.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_association" {
  count                 = length(var.vm_name)
  network_interface_id  = var.network_interface_ids[count.index]
  ip_configuration_name = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}
