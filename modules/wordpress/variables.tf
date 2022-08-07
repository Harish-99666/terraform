variable "app_name" {
  type    = string
  default = "wordpress-app"
}

variable "chart_name" {
  type    = string
  default = "wordpress"
}

variable "repository_url" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "apps" {
  type = list(object({
    name     = string,
    app_name = string
  }))
  default = []
}


variable "service_type" {
  type    = string
  default = "NodePort"
}

variable "enable_http" {
  type    = bool
  default = true
}

variable "external_port" {
  type    = number
  default = 80
}

variable "replica_count" {
  type    = string
  default = 2
}

variable "ns1_annotation" {
  type    = string
  default = "staging-annotation"
}

variable "ns1_label" {
  type    = string
  default = "staging"
}

variable "ns1_name" {
  type    = string
  default = "staging"
}

variable "ns2_annotation" {
  type    = string
  default = "production-annotation"
}

variable "ns2_label" {
  type    = string
  default = "production"
}

variable "ns2_name" {
  type    = string
  default = "production"
}

variable "create_ns1" {
  type    = bool
  default = false
}

variable "create_ns2" {
  type    = bool
  default = false
}