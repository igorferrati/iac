variable "gcp_project" {
  type = string
}

variable "gcp_region" {
  type = string
}

# variable "gcp_zones" {
#   description = "zones"
#   type        = list(string)
#   default     = ["us-central1-a", "us-central1-b", "us-central1-c"]
# }


variable "instance_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_zone" {
  type = string
}

variable "image" {
  type = string
}

variable "qtd" {
  type = number
}