
resource "kind_cluster" "cluster" {
  name = var.cluster_name
  wait_for_ready = true
  node_image = "kindest/node:v${var.cluster_version}"
  kind_config {
    kind        = "Cluster"
      api_version = "kind.x-k8s.io/v1alpha4"

      node {
          role = "control-plane"

          kubeadm_config_patches = [
            "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=${var.ingress_ready}\"\n"
          ] 
        }

    node {
      role = "worker"
      extra_port_mappings {
        container_port = var.container_port
        host_port      = var.host_port
        listen_address = var.listen_address
      }
      labels = {
        environment = var.environment
        node-name   = var.environment == "" ? "dev" : var.environment
      }
    }

  }
}
