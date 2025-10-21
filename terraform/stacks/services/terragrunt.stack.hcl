locals {
    env_vars_map = [
        for name, value in values.env_vars : {
            name = name
            value = value
        }
    ]
    units_path = find_in_parent_folders("terraform/modules")//units
}

unit "cluster" {
    source = "${local.units_path}/cluster"

    path = "cluster"

    values = {
        cluster_name = values.cluster_name
        cluster_version = values.cluster_version
        cluster_context = values.cluster_context
        environment = values.environment
        ingress_ready = values.ingress_ready
        listen_address = values.listen_address
    }
}

unit "s3" {
    source = "${local.units_path}/s3"

    path = "s3"

    values = {
        bucket_name = values.bucket_name
        object_name = values.object_name
        config_filename = values.config_filename
    }
}

unit "ingress" {
    source = "${local.units_path}/ingress"

    path = "ingress"

    values = {
        ingress_ready = values.ingress_ready
        nginx_ingress = {
            namespace = values.cluster_name
            replicas = values.replicas
            ingress_class_name = values.ingress_class_name
            chart_repository   = values.chart_repository
            chart_name         = values.chart_name
            chart_version      = values.chart_version
        }
    }
}

unit "app" {
    source = "${local.units_path}/app"

    path = "app"

    values = {
        s3_app {
            namespace          = values.namespace
            image              = values.image
            replicas           = values.replicas
            ingress_class_name = values.ingress_class_name
            ingress_path       = values.ingress_path # the app should be available locally on localhost:8086/s3-app
            labels = {
            app = values.app.labels
            }
            env_vars = local.env_vars_map # environment variables used by the app
       }     
    }
}