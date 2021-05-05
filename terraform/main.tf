// Networking 
resource "azurerm_resource_group" "vnet_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-networking"
  location = var.loc.long
}

module "networking" {
  source          = "./modules/networking/"
  prefix          = var.prefix
  env             = var.env
  rg_name         = azurerm_resource_group.vnet_rg.name
  loc             = var.loc
  vnet_addr_space = var.vnet_addr_space
  vnet_subnets    = var.vnet_subnets
}

// Monitoring
resource "azurerm_resource_group" "monitoring_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-monitoring"
  location = var.loc.long
}

module "monitoring" {
  source  = "./modules/monitoring/"
  prefix  = var.prefix
  env     = var.env
  rg_name = azurerm_resource_group.monitoring_rg.name
  loc     = var.loc
}

// ACR
resource "azurerm_resource_group" "acr_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-registry"
  location = var.loc.long
}

module "acr" {
  source  = "./modules/acr/"
  prefix  = var.prefix
  env     = var.env
  rg_name = azurerm_resource_group.acr_rg.name
  loc     = var.loc
}

// AKS
resource "azurerm_resource_group" "aks_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-aks"
  location = var.loc.long
}

data "azurerm_subnet" "aks_subnet" {
  name                 = "${var.prefix}-${var.env}-${var.loc.short}-aks"
  virtual_network_name = module.networking.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
}

module "aks" {
  source = "./modules/aks/"

  aks_cluster_name = "${var.prefix}-${var.env}-${var.loc.short}"
  loc              = var.loc
  rg_name          = azurerm_resource_group.aks_rg.name

  kubernetes_version = var.kubernetes_version

  vm_size      = var.aks_vm_size
  default_pool = var.default_pool
  user_pool    = var.user_pool

  vnet_subnet_id = data.azurerm_subnet.aks_subnet.id

  network_profile = {
    network_plugin     = "azure"
    network_policy     = "azure"
    service_cidr       = "10.100.0.0/16"
    dns_service_ip     = "10.100.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    pod_cidr           = null
  }

  log_analytics_workspace_id = module.monitoring.law.id
}

//cluster manager vm
resource "azurerm_resource_group" "vms_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-vms"
  location = var.loc.long
}

data "azurerm_subnet" "vms" {
  name                 = "${var.prefix}-${var.env}-${var.loc.short}-vms"
  virtual_network_name = module.networking.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
}

module "vm" {
  source = "./modules/vm/"
  prefix = var.prefix
  loc = var.loc
  rg_name = azurerm_resource_group.vms_rg.name
  env = var.env

  vm_prefix = "k8s-manager"
  vm_count = 1
  subnet_id = data.azurerm_subnet.vms.id 

  vm_size = "Standard_D2as_v4"

  vm_admin = "suren"
  pub_key_loc = "${path.root}/files/id_rsa.pub"

}


//K8s iaas (k8s from scratch on Vms)
resource "azurerm_resource_group" "k8s_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-k8s"
  location = var.loc.long
}

data "azurerm_subnet" "k8s" {
  name                 = "${var.prefix}-${var.env}-${var.loc.short}-k8s-iaas"
  virtual_network_name = module.networking.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
}

module "k8s-iaas" {
  source = "./modules/k8s-iaas/"  

  prefix = var.prefix
  loc = var.loc
  rg_name = azurerm_resource_group.k8s_rg.name
  env = var.env

  master_count = var.master_count
  worker_count = var.worker_count  
  
  subnet_id = data.azurerm_subnet.k8s.id 
  vm_size = "Standard_D2as_v4"

  vm_admin = "suren"
  pub_key_loc = "${path.root}/files/id_rsa.pub"
}