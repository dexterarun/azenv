variable aks_cluster_name {
    type = string    
}

variable loc {}

variable rg_name {}

variable kubernetes_version {
    type = string    
}

variable vm_size {
    type = string    
}

variable default_pool { 
    type = map  
}

variable user_pool {   
    type = map
}

variable node_labels {
    type = map
    default = {
        "purpose" = "system_workloads"
        "provisioner" = "terraform"
    }
}

variable user_workloads_node_labels {
    type = map
    default = {
        "purpose" = "user_workloads"
        "provisioner" = "terraform"
    }
}

variable vnet_subnet_id {
    type = string
}

variable network_profile {
    type = map
}

variable log_analytics_workspace_id {
    type = string 
}
