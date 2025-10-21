
variable "s3_app" {
  description = "Configuration for deploying the app"
  type = object({
    namespace = string
    image     = string
    replicas  = number
    ingress_class_name = string
    ingress_path       = string
    labels = map(string)
    env_vars = list(object({
      name  = string
      value = string
    }))
  })
}
