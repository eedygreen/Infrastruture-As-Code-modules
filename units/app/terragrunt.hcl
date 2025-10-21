include "root" {
    path = find_in_parent_folders("root.hcl")
}

locals {
    conf = read_terragrunt_config(find_in_parent_folders("config.hcl"))
   
    environment = get_env("environment", "dev")  # for environment deployment
    git_ref = local.conf.locals.versions[local.environment]
    source_url = "${local.conf.locals.base_repo}//modules/app?ref=${local.git_ref}"
}


terraform {
    source =  "${local.conf.locals.base_repo}//modules/app?ref=${local.conf.locals.versions.app}" 
    # source = local.source_url #for environment deployment
}

inputs = {
    env_vars = [
        for env in var.env_vars : merge(env, {
            name = env.name
            value = env.value
        })
    ]
}