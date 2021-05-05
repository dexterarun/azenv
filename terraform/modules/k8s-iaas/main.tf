module "vm_master" {
  source = "../../modules/vm/"
  prefix = var.prefix
  loc = var.loc
  rg_name = var.rg_name
  env = var.env

  vm_prefix = "k8s-master"
  vm_count = var.master_count

  subnet_id = var.subnet_id

  vm_size = var.vm_size

  vm_admin = var.vm_admin
  pub_key_loc = var.pub_key_loc
}

module "vm_worker" {
  source = "../../modules/vm/"
  prefix = var.prefix
  loc = var.loc
  rg_name = var.rg_name
  env = var.env

  vm_prefix = "k8s-worker"
  vm_count = var.worker_count

  subnet_id = var.subnet_id 

  vm_size = var.vm_size

  vm_admin = var.vm_admin
  pub_key_loc = var.pub_key_loc
}

