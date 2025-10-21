include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "${replace(get_path_to_repo_root(), "//units/", "//modules/")}s3"
}

inputs = {
    bucket_name = values.bucket_name
    object_name = values.object_name
    config_filename = values.config_filename
    environment = values.environment
}