include "root" {
    path = find_in_parent_folders("root.hcl")
}

locals {
    conf = read_terragrunt_config(find_in_parent_folders("config.hcl"))
   
    environment = get_env("environment", "dev")  # for environment deployment
    git_ref = local.conf.locals.versions[local.environment]
    source_url = "${local.conf.locals.base_repo}//modules/cluster?ref=${local.git_ref}"
}


terraform {
    source =  "${local.conf.locals.base_repo}//modules/cluster?ref=${local.conf.locals.versions.cluster}" 
    # source = local.source_url #for environment deployment
}


inputs = {
    cluster_name = values.cluster_name
    cluster_version = values.cluster_version
    cluster_context = values.cluster_context
    environment = values.environment
    ingress_ready = values.ingress_ready
    listen_address = values.listen_address
}
