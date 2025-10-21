
output "nginx_ingress_app_version" {
  description = "The version of the NGINX Ingress controller deployed"
  value       = helm_release.nginx_ingress.version
}
