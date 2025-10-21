include "root" {
    path = find_in_parent_folders("root.hcl")
}

locals {
    conf = read_terragrunt_config(find_in_parent_folders("config.hcl"))
   
    environment = get_env("environment", "dev")  # for environment deployment
    git_ref = local.conf.locals.versions[local.environment]
    source_url = "${local.conf.locals.base_repo}//modules/ingress?ref=${local.git_ref}"
}


terraform {
    source =  "${local.conf.locals.base_repo}//modules/ingress?ref=${local.conf.locals.versions.ingress}" 
    # source = local.source_url #for environment deployment
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