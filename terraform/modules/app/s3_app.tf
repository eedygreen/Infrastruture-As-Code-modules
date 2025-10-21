# Deploy a simple stateless web app that serves files from an S3 bucket

# The app should be accessible from localhost via an Ingress on localhost:8086/s3-app
# The app is stateless. No TLS is required (plain HTTP)

# Hint: pay attention to ingressClassName value of the Ingress object for the solution to work

resource "kubernetes_namespace" "s3_app" {
  metadata {
    name = var.s3_app.namespace
  }
}


resource "kubernetes_deployment" "s3_app" {
    metadata {
        name      = var.s3_app.labels.app
        namespace = var.s3_app.namespace
        labels = {
            app = var.s3_app.labels.app
        }
    }
    spec {
        replicas = var.s3_app.replicas
        selector {
            match_labels = {
                app = var.s3_app.labels.app
            }
        }
        template {
            metadata {
                labels = {
                    app = var.s3_app.labels.app
                }
            }
            spec {
                container {
                    name  = var.s3_app.labels.app
                    image = var.s3_app.image
                    port {
                        container_port = local.s3_app_port
                    }
                    dynamic "env" {
                        for_each = var.s3_app.env_vars
                        content {
                            name  = env.value.name
                            value = env.value.value
                        }
                    }
                    
                }
                restart_policy = "Always"
            }
        }
    }
}

locals {
  s3_app_port_value = try(
    [for env in var.s3_app.env_vars : env.value if env.name == "PORT"][0],
    ""
  )
  default_port = coalesce(local.s3_app_port_value, "80")
  s3_app_port = tonumber(local.default_port)
}

resource "kubernetes_service_v1" "s3_app" {
    metadata {
      name      = var.s3_app.labels.app
      namespace = kubernetes_namespace.s3_app.metadata[0].name
      labels = {
        app = var.s3_app.labels.app
      }
    }
    spec {
      selector = {
        app = var.s3_app.labels.app
      }
      port {
        port        = 80
        target_port = local.s3_app_port
      }
      type = "ClusterIP"
    }
    depends_on = [
      kubernetes_namespace.s3_app
    ]
}

resource "kubernetes_ingress_v1" "s3_app" {
    metadata {
      name      = "${var.s3_app.labels.app}-ingress"
      namespace = kubernetes_namespace.s3_app.metadata[0].name
      annotations = {
        "kubernetes.io/ingress.class" = var.s3_app.ingress_class_name
      }
    }
    spec {
      ingress_class_name = var.s3_app.ingress_class_name
      rule {
        http {
            path {
                path = var.s3_app.ingress_path
                path_type = "Prefix"
                backend {
                    service {
                        name = kubernetes_service_v1.s3_app.metadata[0].name
                        port {
                            number = 80
                        }
                    }
                }
                
            }
          }
        }
    }
    depends_on = [
      kubernetes_namespace.s3_app
    ]

}
   