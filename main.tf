locals {
  jaeger_enabled   = var.jaeger_enabled ? 1 : 0
  jaeger_namespace = var.jaeger_namespace

  elasticsearch_enabled   = var.jaeger_enabled ? 1 : 0
  elasticsearch_namespace = var.elasticsearch_namespace

  curator_enabled   = var.curator_enabled ? 1 : 0
  curator_namespace = var.curator_namespace
}

resource "helm_release" "jaeger" {
  count = local.jaeger_enabled

  name       = var.jaeger_release_name
  chart      = var.jaeger_chart_name
  repository = var.jaeger_chart_repository_url
  version    = var.jaeger_chart_version
  namespace  = local.jaeger_namespace

  max_history = var.max_history

  timeout = var.helm_release_timeout_seconds

  values = [
    data.template_file.jaeger[0].rendered,
  ]
}

data "template_file" "jaeger" {
  count = local.jaeger_enabled

  template = file("${path.module}/templates/jaeger.yaml")

  vars = {
    es_client_host = "${var.elasticsearch_cluster_name}-client"
    es_client_port = 9200

    image_tag           = var.jaeger_image_tag
    ingress_hosts       = jsonencode(var.jaeger_ui_ingress_hosts)
    ingress_annotations = jsonencode(var.jaeger_ui_ingress_annotations)
    agent_resources     = jsonencode(var.jaeger_agent_resources)
    collector_resources = jsonencode(var.jaeger_collector_resources)
    query_resources     = jsonencode(var.jaeger_query_resources)
  }
}
