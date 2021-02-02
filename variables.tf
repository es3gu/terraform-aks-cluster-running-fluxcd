variable "rg-name" {
  default     = "aks-rg"
}

variable "rg-location" {
  default     = "UK South"
}

variable "aks-name" {
  default     = "aks-cluster"
}

variable "aks-version" {
  default     = "1.19.6"
}

variable "aks-dns" {
   default    = "aksfluxcd"
}

variable "git-user" {
  default     = ""
  description = "Your github user"
}

variable "git-email" {
  default     = ""
  description = "Your github email"
}
variable "git-url" {
  default     = ""
  description = "Your github url"
}

variable "git-pollInterval" {
  default     = ""
  description = "Sync time"
}

variable "git-branch" {
  default     = ""
  description = "Branch to monitor"
}
variable "namespace" {
  default     = ""
  description = "Namespace of flux"
}