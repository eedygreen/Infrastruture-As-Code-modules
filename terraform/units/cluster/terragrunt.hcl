include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "${find_in_parent_folders("terraform/modules")}//cluster"
}

inputs = {
    cluster_name = values.cluster_name
    cluster_version = values.cluster_version
    cluster_context = values.cluster_context
    environment = values.environment
    ingress_ready = values.ingress_ready
    listen_address = values.listen_address
}
