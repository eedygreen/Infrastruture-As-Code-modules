
output "cluster_endpoint" {
  description = "The endpoint of the kind cluster"
  value       = kind_cluster.cluster.endpoint
}
output "cluster_name" {
  description = "The name of the kind cluster"
  value       = kind_cluster.cluster.name
}
output "kubeconfig" {
  description = "The kubeconfig file content to access the kind cluster"
  value       = kind_cluster.cluster.kubeconfig
}