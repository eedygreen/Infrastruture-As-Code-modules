include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "${find_in_parent_folders("terraform/modules")}//app"
}

inputs = {
    env_vars = [
        for env in var.env_vars : merge(env, {
            name = env.name
            value = env.value
        })
    ]
}