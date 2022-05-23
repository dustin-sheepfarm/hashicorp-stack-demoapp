variable "consul_gossip_key" {
  type        = string
  sensitive   = true
  description = "Consul's Gossip Encryption Key. Generate with `consul keygen`."
}

variable "consul_datacenter" {
  type        = string
  description = "Consul datacenter in Kubernetes cluster"
  default     = "dc1"
}

variable "consul_namespace" {
  type        = string
  description = "Kubernetes namespace for Consul cluster"
  default     = "default"
}

variable "vault_consul_pki_backend" {
  type        = string
  description = "Vault backend with Consul PKI secrets engine"
  default     = "consul/pki_int"
}

variable "tfc_organization" {
  type        = string
  description = "TFC Organization for remote state of infrastructure"
}

variable "tfc_workspace" {
  type        = string
  description = "TFC Organization for remote state of infrastructure"
}

data "terraform_remote_state" "infrastructure" {
  backend = "remote"

  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.tfc_workspace
    }
  }
}

data "terraform_remote_state" "setup" {
  backend = "remote"

  config = {
    organization = var.tfc_organization
    workspaces = {
      name = "vault-setup"
    }
  }
}

locals {
  hcp_vault_cluster_id       = var.hcp_vault_cluster_id == "" ? data.terraform_remote_state.infrastructure.outputs.hcp_vault_cluster : var.hcp_vault_cluster_id
  hcp_vault_cluster_token    = var.hcp_vault_cluster_token == "" ? data.terraform_remote_state.infrastructure.outputs.hcp_vault_token : var.hcp_vault_cluster_token
  vault_kubernetes_auth_path = data.terraform_remote_state.setup.outputs.vault_kubernetes_auth_path
}

data "hcp_vault_cluster" "cluster" {
  cluster_id = local.hcp_vault_cluster_id
}

variable "hcp_vault_cluster_id" {
  type        = string
  description = "HCP Vault Cluster ID for configuration"
  default     = ""
}

variable "hcp_vault_cluster_token" {
  type        = string
  description = "HCP Vault Cluster token for configuration"
  default     = ""
  sensitive   = true
}