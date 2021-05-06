// common
prefix = "azenv"
env    = "demo"
loc = {
  short = "uks"
  long  = "uk south"
}

// networking
vnet_addr_space = ["10.0.0.0/16"]
vnet_subnets = [
  {
    name        = "default"
    cidr        = ["10.0.0.0/24"]
    default_nsg = true
  },
  {
    name        = "vms"
    cidr        = ["10.0.1.0/24"]
    default_nsg = true
  },
  {
    name        = "GatewaySubnet"
    cidr        = ["10.0.2.0/24"]
    default_nsg = false
  },
  {
    name        = "AzureBastionSubnet"
    cidr        = ["10.0.3.0/24"]
    default_nsg = false
  },
  {
    name        = "aks"
    cidr        = ["10.0.16.0/20"]
    default_nsg = false
  },
  {
    name        = "k8s-iaas"
    cidr        = ["10.0.48.0/20"]
    default_nsg = true
  }
]

// aks
aks_cluster_name   = "azenv-dev-uks"
kubernetes_version = "1.20.5"
aks_vm_size        = "Standard_B2s"
default_pool = {
  init_count = 2
  min_count  = 2
  max_count  = 4
}
user_pool = {
  init_count = 2
  min_count  = 2
  max_count  = 4
}

// k8s iaas 
cluster_prefix = "k8s"
master_count   = 1
worker_count   = 3
vm_size        = "Standard_D2as_v4"