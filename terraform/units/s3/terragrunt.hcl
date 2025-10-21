include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "${find_in_parent_folders("terraform/modules")}//s3"
}

inputs = {
    bucket_name = values.bucket_name
    object_name = values.object_name
    config_filename = values.config_filename
    environment = values.environment
}