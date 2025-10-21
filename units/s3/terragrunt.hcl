include "root" {
    path = find_in_parent_folders("root.hcl")
}

locals {
    conf = read_terragrunt_config(find_in_parent_folders("config.hcl"))
   
    environment = get_env("environment", "dev")  # for environment deployment
    git_ref = local.conf.locals.versions[local.environment]
    source_url = "${local.conf.locals.base_repo}//modules/s3?ref=${local.git_ref}"
}


terraform {
    source =  "${local.conf.locals.base_repo}//modules/ingress?ref=${local.conf.locals.versions.ingress}" 
    # source = local.source_url #for environment deployment
}

inputs = {
    bucket_name = values.bucket_name
    object_name = values.object_name
    config_filename = values.config_filename
    environment = values.environment
}