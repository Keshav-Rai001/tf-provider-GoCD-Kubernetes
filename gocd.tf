provider "kubernetes" {
  host                   = "${var.kubernetes_ip}"
  config_context_cluster = "mycluster.icp"
  token                  = "${var.k8s_token}"
  insecure               = "true"
}

resource "kubernetes_service" "test_service" {
  metadata {
    name = "${var.pod_name}"
  }

  spec {
    selector {
      app = "${kubernetes_pod.gocd.metadata.0.labels.app}"
    }

    port {
      port        = 8154
      target_port = 8154
    }

    type = "NodePort"
  }
}

resource "kubernetes_pod" "gocd" {
  metadata {
    name = "gocd-example"

    labels {
      app = "gocd"
    }
  }

  spec {
    container {
      image = "gocd/gocd-server:v18.8.0"
      name  = "example"

      port {
        container_port = 443
      }
    }
  }
}
