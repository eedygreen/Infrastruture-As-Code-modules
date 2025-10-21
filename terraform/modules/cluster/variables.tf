


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

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
  default     = true
}
