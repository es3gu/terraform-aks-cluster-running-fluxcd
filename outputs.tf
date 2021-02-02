output "host" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.host
}

output "client_key" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_key
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate
}