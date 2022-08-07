variable "app_name" {
  type    = string
  default = "prometheus-app"
}

variable "chart_name" {
  type    = string
  default = "kube-prometheus-stack"
}

variable "repository_url" {
  type    = string
  default = "https://prometheus-community.github.io/helm-charts"
}

variable "psp" {
  type    = bool
  default = true
}

variable "pvc" {
  type    = bool
  default = false
}

variable "namespace" {
  type    = string
  default = "null"
}