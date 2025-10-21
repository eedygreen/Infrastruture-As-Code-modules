include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "${find_in_parent_folders("infrastructure/modules")}//ingress"
    
}

inputs = {
    ingress_ready = values.ingress_ready
    listen_address = value.listen_address
    container_port = values.container_port
    environment = values.environment
    nginx_ingress = {
        namespace = values.namespace
        replicas = values.replicas
        ingress_class_name = values.ingress_class_name
        chart_repository   = values.chart_repository
        chart_name         = values.chart_name
        chart_version      = values.chart_version
    }
}