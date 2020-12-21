resource "helm_release" "curator" {
  count = local.curator_enabled

  name       = var.curator_release_name
  chart      = var.curator_chart_name
  repository = var.curator_chart_repository
  version    = var.curator_chart_version
  namespace  = local.curator_namespace

  timeout = var.helm_release_timeout_seconds

  max_history = var.max_history

  values = [
    data.template_file.curator[0].rendered,
  ]
}

data "template_file" "curator" {
  count = local.curator_enabled

  template = file("${path.module}/templates/curator.yaml")

  vars = {
    es_client_host = "${var.elasticsearch_cluster_name}-client"
    es_client_port = 9200

    image_tag     = var.curator_image_tag
    cron_schedule = var.curator_cron_schedule
    actions       = jsonencode(var.curator_actions)
  }
}
