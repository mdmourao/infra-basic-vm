variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "project_number" {
  description = "Project Number"
  type        = number
}

variable "region" {
  description = "Deploy region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Deploy Zone"
  type        = string
  default     = "us-central1-a"
}

variable "ip_cidr_range" {
  description = "IP Range"
  type        = string
}

variable "machine_type" {
  description = "The machine type to create."
  type        = string
  default     = "e2-micro"
}
