include "root" {
    path = find_in_parent_folders("root.hcl")
}

locals {
    conf = read_terragrunt_config(find_in_parent_folders("config.hcl"))
   
    environment = get_env("environment", "dev")  # for environment deployment
    git_ref = local.conf.locals.versions[local.environment]
    source_url = "${local.conf.locals.base_repo}//modules/vpc?ref=${local.git_ref}"
}


terraform {
    source =  "${local.conf.locals.base_repo}//modules/vpc?ref=${local.conf.locals.versions.s3}" 
    # source = local.source_url #for environment deployment
}

inputs = {
    region = values.region 
    env = values.env
    cidr = values.cidr
    public_subnets = values.public_subnets
    private_subnets = values.private_subnets
    database_subnets = values.database_subnets
    elasticache_subnets = values.elasticache_subnets
}