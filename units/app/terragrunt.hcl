include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "${replace(get_path_to_repo_root(), "//units/", "//modules/")}app"
}

inputs = {
    env_vars = [
        for env in var.env_vars : merge(env, {
            name = env.name
            value = env.value
        })
    ]
}