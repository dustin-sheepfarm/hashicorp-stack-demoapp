terraform {
  required_version = "~> 1.0"
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.29"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.6"
    }
  }
}

provider "vault" {
  address   = data.hcp_vault_cluster.cluster.vault_public_endpoint_url
  token     = local.hcp_vault_cluster_token
  namespace = data.hcp_vault_cluster.cluster.namespace
}

provider "hcp" {
  client_id = var.HCP_CLIENT_ID
  client_secret = var.HCP_CLIENT_SECRET
}