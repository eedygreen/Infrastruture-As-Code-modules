variable "region" {
  type        = string
  description = "AWS region"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnets" {
  type        = list(string)
  default     = []
  description = "List of public subnet CIDR blocks"
}

variable "private_subnets" {
  type        = list(string)
  default     = []
  description = "List of private subnet CIDR blocks"
}

variable "database_subnets" {
  type        = list(string)
  default     = []
  description = "List of database subnet CIDR blocks"
}

variable "elasticache_subnets" {
  type        = list(string)
  default     = []
  description = "List of elasticache subnet CIDR blocks"
}