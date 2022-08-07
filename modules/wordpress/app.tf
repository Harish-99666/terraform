resource "helm_release" "wordpress" {

  name = var.apps[count.index].app_name

  repository = var.repository_url
  chart      = var.chart_name

  count     = length(var.apps)
  namespace = var.apps[count.index].name

  values = [
    "${file("templates/ns1-values.yaml")}",
    "${file("templates/ns2-values.yaml")}"
  ]

  set {
    name  = "service.type"
    value = var.service_type
  }

  set {
    name  = "protocolHttp"
    value = var.enable_http
  }

  set {
    name  = "service.externalPort"
    value = var.external_port
  }

  set {
    name  = "replicaCount"
    value = var.replica_count
  }
}

