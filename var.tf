variable "kubernetes_ip" {
  description = "Address of kubernetes cluster"
}

variable "pod_name" {
  description = "Name of kubernets service/pod"
  default     = "random-pod"
}
