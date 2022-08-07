resource "helm_release" "prometheus" {
  chart      = var.chart_name
  name       = var.app_name
  namespace  = var.namespace
  repository = var.repository_url

  set {
    name  = "podSecurityPolicy.enabled"
    value = var.psp
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = var.pvc
  }
}

