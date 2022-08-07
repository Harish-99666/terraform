module "wordpress" {
  source = "../modules/wordpress"

  chart_name    = "wordpress"
  replica_count = "1"

  create_ns1 = true
  create_ns2 = true

  apps = [
    {
      name     = "staging",
      app_name = "wordpress-01",
    },
    {
      name     = "production",
      app_name = "wordpress-02",
    }
  ]
}


module "prometheus" {
  source = "../modules/prometheus"

  chart_name = "kube-prometheus-stack"
  app_name   = "prometheus-01"

  namespace = "default"
}

