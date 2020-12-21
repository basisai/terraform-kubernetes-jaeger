# Elasticsearch master nodes
resource "helm_release" "elasticsearch" {
  count = local.elasticsearch_enabled

  name       = var.elasticsearch_release_name
  chart      = var.elasticsearch_chart_name
  repository = var.elasticsearch_chart_repository_url
  version    = var.elasticsearch_chart_version
  namespace  = local.elasticsearch_namespace

  timeout = var.helm_release_timeout_seconds

  max_history = var.max_history

  values = [
    data.template_file.elasticsearch[0].rendered,
  ]
}

# Elasticsearch data nodes
resource "helm_release" "elasticsearch_data" {
  count = local.elasticsearch_enabled

  name       = "${var.elasticsearch_release_name}-data"
  chart      = var.elasticsearch_chart_name
  repository = var.elasticsearch_chart_repository_url
  version    = var.elasticsearch_chart_version
  namespace  = local.elasticsearch_namespace

  timeout = var.helm_release_timeout_seconds

  max_history = var.max_history

  values = [
    data.template_file.elasticsearch_data[0].rendered,
  ]
}

# Elasticsearch client nodes
resource "helm_release" "elasticsearch_client" {
  count = local.elasticsearch_enabled

  name       = "${var.elasticsearch_release_name}-client"
  chart      = var.elasticsearch_chart_name
  repository = var.elasticsearch_chart_repository_url
  version    = var.elasticsearch_chart_version
  namespace  = local.elasticsearch_namespace

  timeout = var.helm_release_timeout_seconds

  max_history = var.max_history

  values = [
    data.template_file.elasticsearch_client[0].rendered,
  ]
}

data "template_file" "elasticsearch" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch.yaml")

  vars = {
    es_cluster_name = var.elasticsearch_cluster_name

    es_image                        = var.elasticsearch_image
    es_image_tag                    = var.elasticsearch_image_tag
    es_major_version                = var.elasticsearch_major_version
    es_rbac_enable                  = var.elasticsearch_rbac_enable || var.elasticsearch_psp_enable
    es_psp_enable                   = var.elasticsearch_psp_enable
    es_master_minimum_replicas      = var.elasticsearch_master_minimum_replicas
    es_master_replicas              = var.elasticsearch_master_replicas
    es_master_resources             = jsonencode(var.elasticsearch_master_resources)
    es_master_persistence_disk_size = var.elasticsearch_master_persistence_disk_size
  }
}

data "template_file" "elasticsearch_data" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch_data.yaml")

  vars = {
    es_cluster_name = var.elasticsearch_cluster_name

    es_image                      = var.elasticsearch_image
    es_image_tag                  = var.elasticsearch_image_tag
    es_major_version              = var.elasticsearch_major_version
    es_rbac_enable                = var.elasticsearch_rbac_enable || var.elasticsearch_psp_enable
    es_psp_enable                 = var.elasticsearch_psp_enable
    es_data_replicas              = var.elasticsearch_data_replicas
    es_data_resources             = jsonencode(var.elasticsearch_data_resources)
    es_data_persistence_disk_size = var.elasticsearch_data_persistence_disk_size
  }
}

data "template_file" "elasticsearch_client" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch_client.yaml")

  vars = {
    es_cluster_name = var.elasticsearch_cluster_name

    es_image                        = var.elasticsearch_image
    es_image_tag                    = var.elasticsearch_image_tag
    es_major_version                = var.elasticsearch_major_version
    es_rbac_enable                  = var.elasticsearch_rbac_enable || var.elasticsearch_psp_enable
    es_psp_enable                   = var.elasticsearch_psp_enable
    es_client_replicas              = var.elasticsearch_client_replicas
    es_client_resources             = jsonencode(var.elasticsearch_client_resources)
    es_client_persistence_disk_size = var.elasticsearch_client_persistence_disk_size
  }
}
