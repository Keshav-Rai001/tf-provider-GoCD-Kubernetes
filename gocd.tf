provider "kubernetes" 
{
 host = "${var.kubernetes_ip}"  

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
      port        = 8153
      target_port = 8153
    }

    type = "NodePort"
  }
}

resource "kubernetes_pod" "gocd" 
{
 metadata 
 {
   name = "gocd-example"    labels
   {
     app = "gocd"
   }
 }  
 spec
  {
   container
    {
     image = "gocd/gocd-server:v18.8.0"
     name  = "example"      
     port 
     {
       container_port = 80
     }
   }
 }
}
