variable "host_port" {
  description = "The host port to map to container port 80 in the kind cluster"
  type        = number
  default     = 8086
}

variable "container_port" {
  description = "The container port to map to host port in the kind cluster"
  type        = number
  default     = 80
}

variable "ingress_ready" {
  description = "Whether to set the ingress-ready label on the control-plane node"
  type        = bool
  default     = true
}

variable "listen_address" {
  description = "The listen address for the port mapping in the kind cluster"
  type        = string
  default     = "0.0.0.0"
}

variable "environment" {   
  description = "The environment tag to apply to resources"
  type        = string
  default     = "dev"
}

variable "nginx_ingress" {
  description = "Configuration for deploying the NGINX Ingress controller via Helm"
  type = object({
    namespace          = string
    replicas           = number
    ingress_class_name = string
    chart_repository   = string
    chart_name         = string
    chart_version      = string
  })
}