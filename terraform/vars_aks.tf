variable "aks_cluster_name" {
    default = "azenv-dev-uks"
}

variable "kubernetes_version" {
    default = "1.15.5"
}

variable vm_size {
    default = "Standard_B2s"
}

variable default_pool {
    default = {
        init_count = 2
        min_count = 2
        max_count = 4
    }
}

variable user_pool {
    default = {
        init_count = 2
        min_count = 2
        max_count = 4
    }
}