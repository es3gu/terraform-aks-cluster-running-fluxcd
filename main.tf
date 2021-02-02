resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.rg-location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.aks-name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks-dns
  kubernetes_version  = var.aks-version

  identity {
    type = "SystemAssigned"
  }
 
  role_based_access_control {
      enabled = false
    }

  default_node_pool {
    name       = "aksnp"
    node_count = 1
    vm_size    = "Standard_B2s"
    max_pods   = 30
  }
}

provider "kubernetes" {
  host = azurerm_kubernetes_cluster.k8s.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
}

resource "kubernetes_namespace" "fluxcd" {
  metadata {
    name = "fluxcd"
  }

  depends_on = [
      azurerm_kubernetes_cluster.k8s
  ]
}

provider "helm" {
  kubernetes {  
     host = azurerm_kubernetes_cluster.k8s.kube_config.0.host
     client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
     client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
     cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
  }
}

resource "helm_release" "fluxcd" {
  name       = "fluxcd"
  repository = "https://charts.fluxcd.io"
  chart      = "flux"
  namespace  = "fluxcd"

  set {
    name  = "git.user"
    value = var.git-user
  }

  set {
    name  = "git.email"
    value = var.git-email
  }

  set {
    name  = "git.url"
    value = var.git-url
  }

  set {
    name  = "git.pollInterval"
    value = var.git-pollInterval
  }

  set {
    name  = "git.branch"
    value = var.git-branch
  }

  set {
    name  = "namespace"
    value = var.git-email
  }

  depends_on = [
      kubernetes_namespace.fluxcd
  ]
}