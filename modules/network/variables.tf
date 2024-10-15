variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "region" {
  description = "Deploy region"
  type        = string
}

variable "ip_cidr_range" {
  description = "IP Range"
  type        = string
  default     = "10.7.0.0/16"
}
