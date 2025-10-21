# Deploy the NGINX Ingress controller in the kind cluster in a given namespace.
# Deployment needs to the done using the ingress-nginx helm chart (see
# 02-app-deploy/main.tf for details)
# Use nginx-helm-chart-values-template.yml to generate the values for the helm chart
# (hint: use the Terraform's templatefile function)

resource "kubernetes_namespace" "nginx" {
  metadata {
    name = var.nginx_ingress.namespace
  }
}


# Generate the values for the helm chart using templatefile directly
locals {
  nginx_values = templatefile("${path.module}/nginx-helm-chart-values-template.yaml", {
    ingressClassName = var.nginx_ingress.ingress_class_name
    replicas           = var.nginx_ingress.replicas
  })
}

resource "helm_release" "nginx_ingress" {
  name       = var.nginx_ingress.ingress_class_name
  repository = var.nginx_ingress.chart_repository
  chart      = var.nginx_ingress.chart_name
  version    = var.nginx_ingress.chart_version
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  
  values     = [
    local.nginx_values
  ]

  depends_on = [
    kubernetes_namespace.nginx
  ]
}
