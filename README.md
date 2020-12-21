# Jaeger tracing

This TF module deploys a Jaeger backend that includes an Elasticsearch cluster. Also, it schedules a cron job that cleans up tracing data that is older than 4 weeks, i.e. it has a default retention period of 4 weeks.

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| curator\_actions | Curator actions | `map` | <pre>{<br>  "actions": {<br>    "1": {<br>      "action": "delete_indices",<br>      "description": "Clean up ES by deleting old indices",<br>      "filters": [<br>        {<br>          "direction": "older",<br>          "exclude": false,<br>          "filtertype": "age",<br>          "source": "creation_date",<br>          "unit": "days",<br>          "unit_count": 28<br>        }<br>      ],<br>      "options": {<br>        "continue_if_exception": false,<br>        "disable_action": false,<br>        "ignore_empty_list": true,<br>        "timeout_override": 300<br>      }<br>    }<br>  }<br>}</pre> | no |
| curator\_chart\_name | Chart name for Curator | `string` | `"elasticsearch-curator"` | no |
| curator\_chart\_repository | Chart repository for Curator | `string` | `"stable"` | no |
| curator\_chart\_version | Chart version for Curator | `string` | `"2.1.3"` | no |
| curator\_cron\_schedule | Crontab which Curator will run | `string` | `"0 16 * * *"` | no |
| curator\_enabled | Enable/disable Curator | `bool` | `false` | no |
| curator\_image\_tag | Curator's docker image tag | `string` | `"5.7.6"` | no |
| curator\_namespace | Kubernetes namespace to which Curator is deployed | `string` | `"core"` | no |
| curator\_release\_name | Helm release name for Curator | `string` | `"elasticsearch-curator"` | no |
| elasticsearch\_chart\_name | Chart name for Elasticsearch | `string` | `"elasticsearch"` | no |
| elasticsearch\_chart\_repository | Chart repository for Elasticsearch | `string` | `"elastic"` | no |
| elasticsearch\_chart\_repository\_url | Chart repository for Elasticsearch | `string` | `"https://helm.elastic.co"` | no |
| elasticsearch\_chart\_version | Chart version for Elasticsearch | `string` | `"7.5.1"` | no |
| elasticsearch\_client\_persistence\_disk\_size | Persistence disk size in each Elasticsearch client node | `string` | `"1Gi"` | no |
| elasticsearch\_client\_replicas | Num of replicas of Elasticsearch client node | `number` | `2` | no |
| elasticsearch\_client\_resources | Kubernetes resources for Elasticsearch client node | `map` | <pre>{<br>  "limits": {<br>    "cpu": "1",<br>    "memory": "1536Mi"<br>  },<br>  "requests": {<br>    "cpu": "25m",<br>    "memory": "1536Mi"<br>  }<br>}</pre> | no |
| elasticsearch\_cluster\_name | Name if the elasticsearch cluster | `string` | `"tracing"` | no |
| elasticsearch\_data\_persistence\_disk\_size | Persistence disk size in each Elasticsearch data node | `string` | `"30Gi"` | no |
| elasticsearch\_data\_replicas | Num of replicas of Elasticsearch data node | `number` | `2` | no |
| elasticsearch\_data\_resources | Kubernetes resources for Elasticsearch data node | `map` | <pre>{<br>  "limits": {<br>    "cpu": "1",<br>    "memory": "2560Mi"<br>  },<br>  "requests": {<br>    "cpu": "25m",<br>    "memory": "2560Mi"<br>  }<br>}</pre> | no |
| elasticsearch\_image | Elasticsearch image | `string` | `"docker.elastic.co/elasticsearch/elasticsearch-oss"` | no |
| elasticsearch\_image\_tag | Elasticsearch imagetag | `string` | `"6.8.2"` | no |
| elasticsearch\_major\_version | Used to set major version specific configuration. If you are using a custom image and not running the default Elasticsearch version you will need to set this to the version you are running | `number` | `6` | no |
| elasticsearch\_master\_minimum\_replicas | The value for discovery.zen.minimum\_master\_nodes. Should be set to (master\_eligible\_nodes / 2) + 1. Ignored in Elasticsearch versions >= 7. | `number` | `2` | no |
| elasticsearch\_master\_persistence\_disk\_size | Persistence disk size in each Elasticsearch master node | `string` | `"4Gi"` | no |
| elasticsearch\_master\_replicas | Num of replicas of Elasticsearch master node | `number` | `3` | no |
| elasticsearch\_master\_resources | Kubernetes resources for Elasticsearch master node | `map` | <pre>{<br>  "limits": {<br>    "cpu": "1",<br>    "memory": "1536Mi"<br>  },<br>  "requests": {<br>    "cpu": "25m",<br>    "memory": "1536Mi"<br>  }<br>}</pre> | no |
| elasticsearch\_namespace | Kubernetes namespace to which Elasticsearch is deployed | `string` | `"core"` | no |
| elasticsearch\_psp\_enable | Create PodSecurityPolicy for ES resources | `bool` | `true` | no |
| elasticsearch\_rbac\_enable | Create RBAC for ES resources | `bool` | `true` | no |
| elasticsearch\_release\_name | Helm release name for Elasticsearch | `string` | `"jaeger-elasticsearch"` | no |
| helm\_release\_timeout\_seconds | Time in seconds to wait for any individual kubernetes operation during a helm release. | `number` | `900` | no |
| jaeger\_agent\_resources | Kubernetes resources for Jaeger Agent service | `map` | <pre>{<br>  "limits": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  },<br>  "requests": {<br>    "cpu": "25m",<br>    "memory": "128Mi"<br>  }<br>}</pre> | no |
| jaeger\_chart\_name | Chart name for Jaeger | `string` | `"jaeger"` | no |
| jaeger\_chart\_repository | Chart repository for Jaeger | `string` | `"jaegertracing"` | no |
| jaeger\_chart\_repository\_url | Chart repository for Jaeger | `string` | `"https://jaegertracing.github.io/helm-charts"` | no |
| jaeger\_chart\_version | Chart version for Jaeger | `string` | `"0.18.2"` | no |
| jaeger\_collector\_resources | Kubernetes resources for Jaeger Collector service | `map` | <pre>{<br>  "limits": {<br>    "cpu": "512m",<br>    "memory": "256Mi"<br>  },<br>  "requests": {<br>    "cpu": "50m",<br>    "memory": "256Mi"<br>  }<br>}</pre> | no |
| jaeger\_enabled | Enable/disable Jaeger | `bool` | `false` | no |
| jaeger\_image\_tag | Jaeger's docker image tag | `string` | `"1.16.0"` | no |
| jaeger\_namespace | Kubernetes namespace to which Jaeger is deployed | `string` | `"core"` | no |
| jaeger\_query\_resources | Kubernetes resources for Jaeger Query service | `map` | <pre>{<br>  "limits": {<br>    "cpu": "200m",<br>    "memory": "128Mi"<br>  },<br>  "requests": {<br>    "cpu": "25m",<br>    "memory": "128Mi"<br>  }<br>}</pre> | no |
| jaeger\_release\_name | Helm release name for Jaeger | `string` | `"jaeger"` | no |
| jaeger\_ui\_ingress\_annotations | Ingress annotations for the Jaeger Query service | `map` | `{}` | no |
| jaeger\_ui\_ingress\_hosts | Ingress hosts for the Jaeger Query service | `map` | `{}` | no |
| max\_history | Max History for Helm | `number` | `20` | no |

## Outputs

No output.
