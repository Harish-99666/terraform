resource "kubernetes_namespace" "ns1" {
  count = var.create_ns1 ? 1 : 0
  metadata {
    annotations = {
      name = var.ns1_annotation
    }

    labels = {
      namespace = var.ns1_label
    }

    name = var.ns1_name
  }
}

resource "kubernetes_namespace" "ns2" {
  count = var.create_ns2 ? 1 : 0
  metadata {
    annotations = {
      name = var.ns2_annotation
    }

    labels = {
      namespace = var.ns2_label
    }

    name = var.ns2_name
  }
}
