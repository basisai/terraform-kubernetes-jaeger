variable "helm_release_timeout_seconds" {
  description = "Time in seconds to wait for any individual kubernetes operation during a helm release."
  default     = 900
}

variable "max_history" {
  description = "Max History for Helm"
  default     = 20
}

###########################
# Jaeger
###########################

variable "jaeger_enabled" {
  description = "Enable/disable Jaeger"
  default     = false
}

variable "jaeger_release_name" {
  description = "Helm release name for Jaeger"
  default     = "jaeger"
}

variable "jaeger_chart_name" {
  description = "Chart name for Jaeger"
  default     = "jaeger"
}

variable "jaeger_chart_repository_url" {
  description = "Chart repository for Jaeger"
  default     = "https://jaegertracing.github.io/helm-charts"
}

variable "jaeger_chart_version" {
  description = "Chart version for Jaeger"
  default     = "0.39.7"
}

variable "jaeger_image_tag" {
  description = "Jaeger's docker image tag"
  default     = "1.20.0"
}

variable "jaeger_namespace" {
  description = "Kubernetes namespace to which Jaeger is deployed"
  default     = "core"
}

variable "jaegar_ui_ingress_enabled" {
  description = "Enable Ingress for Jaegar UI"
  default     = true
}

variable "jaeger_ui_ingress_hosts" {
  description = "Ingress hosts for the Jaeger Query service"
  default     = {}
}

variable "jaeger_ui_ingress_annotations" {
  description = "Ingress annotations for the Jaeger Query service"
  default     = {}
}

variable "jaeger_query_resources" {
  description = "Kubernetes resources for Jaeger Query service"
  default = {
    limits = {
      cpu    = "200m"
      memory = "128Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "128Mi"
    }
  }
}

variable "jaeger_collector_resources" {
  description = "Kubernetes resources for Jaeger Collector service"
  default = {
    limits = {
      cpu    = "512m"
      memory = "256Mi"
    }
    requests = {
      cpu    = "50m"
      memory = "256Mi"
    }
  }
}

variable "jaeger_agent_resources" {
  description = "Kubernetes resources for Jaeger Agent service"
  default = {
    limits = {
      cpu    = "100m"
      memory = "128Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "128Mi"
    }
  }
}

###########################
# Elasticsearch cluster
###########################
variable "elasticsearch_release_name" {
  description = "Helm release name for Elasticsearch"
  default     = "jaeger-elasticsearch"
}

variable "elasticsearch_chart_name" {
  description = "Chart name for Elasticsearch"
  default     = "elasticsearch"
}

variable "elasticsearch_chart_repository_url" {
  description = "Chart repository for Elasticsearch"
  default     = "https://helm.elastic.co"
}

variable "elasticsearch_chart_version" {
  description = "Chart version for Elasticsearch"
  default     = "7.5.1"
}

variable "elasticsearch_namespace" {
  description = "Kubernetes namespace to which Elasticsearch is deployed"
  default     = "core"
}

variable "elasticsearch_image" {
  description = "Elasticsearch image"
  default     = "docker.elastic.co/elasticsearch/elasticsearch-oss"
}

variable "elasticsearch_image_tag" {
  description = "Elasticsearch imagetag"
  default     = "6.8.2"
}

variable "elasticsearch_major_version" {
  description = "Used to set major version specific configuration. If you are using a custom image and not running the default Elasticsearch version you will need to set this to the version you are running"
  default     = 6
}

variable "elasticsearch_cluster_name" {
  description = "Name if the elasticsearch cluster"
  default     = "tracing"
}

variable "elasticsearch_psp_enable" {
  description = "Create PodSecurityPolicy for ES resources"
  default     = true
}

variable "elasticsearch_rbac_enable" {
  description = "Create RBAC for ES resources"
  default     = true
}

variable "elasticsearch_client_resources" {
  description = "Kubernetes resources for Elasticsearch client node"
  default = {
    limits = {
      cpu    = "1"
      memory = "1536Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "1536Mi"
    }
  }
}

variable "elasticsearch_client_replicas" {
  description = "Num of replicas of Elasticsearch client node"
  default     = 2
}

variable "elasticsearch_client_persistence_disk_size" {
  description = "Persistence disk size in each Elasticsearch client node"
  default     = "1Gi"
}

variable "elasticsearch_master_resources" {
  description = "Kubernetes resources for Elasticsearch master node"
  default = {
    limits = {
      cpu    = "1"
      memory = "1536Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "1536Mi"
    }
  }
}

variable "elasticsearch_master_minimum_replicas" {
  description = "The value for discovery.zen.minimum_master_nodes. Should be set to (master_eligible_nodes / 2) + 1. Ignored in Elasticsearch versions >= 7."
  default     = 2
}

variable "elasticsearch_master_replicas" {
  description = "Num of replicas of Elasticsearch master node"
  default     = 3
}

variable "elasticsearch_master_persistence_disk_size" {
  description = "Persistence disk size in each Elasticsearch master node"
  default     = "4Gi"
}

variable "elasticsearch_data_resources" {
  description = "Kubernetes resources for Elasticsearch data node"
  default = {
    limits = {
      cpu    = "1"
      memory = "2560Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "2560Mi"
    }
  }
}

variable "elasticsearch_data_replicas" {
  description = "Num of replicas of Elasticsearch data node"
  default     = 2
}

variable "elasticsearch_data_persistence_disk_size" {
  description = "Persistence disk size in each Elasticsearch data node"
  default     = "30Gi"
}

###########################
# Elasticsearch Curator
###########################
variable "curator_enabled" {
  description = "Enable/disable Curator"
  default     = false
}

variable "curator_release_name" {
  description = "Helm release name for Curator"
  default     = "elasticsearch-curator"
}

variable "curator_chart_name" {
  description = "Chart name for Curator"
  default     = "elasticsearch-curator"
}

variable "curator_chart_repository" {
  description = "Chart repository for Curator"
  default     = "stable"
}

variable "curator_chart_version" {
  description = "Chart version for Curator"
  default     = "2.1.3"
}

variable "curator_image_tag" {
  description = "Curator's docker image tag"
  default     = "5.7.6"
}

variable "curator_namespace" {
  description = "Kubernetes namespace to which Curator is deployed"
  default     = "core"
}

variable "curator_cron_schedule" {
  description = "Crontab which Curator will run"
  default     = "0 16 * * *"
}

variable "curator_actions" {
  description = "Curator actions"
  default = {
    actions = {
      1 = {
        action      = "delete_indices"
        description = "Clean up ES by deleting old indices"
        options = {
          timeout_override      = 300
          continue_if_exception = false
          disable_action        = false
          ignore_empty_list     = true
        }
        filters = [
          {
            filtertype = "age"
            source     = "creation_date"
            direction  = "older"
            unit       = "days"
            unit_count = 28
            exclude    = false
          }
        ]
      }
    }
  }
}
