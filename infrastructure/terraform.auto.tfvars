region                     = "us-west-2"
hcp_region                 = "us-west-2"
datadog_region             = "us1"
key_pair_name              = "dustin_ssh_key_uswest-2"
name                       = "hashi"
hcp_consul_public_endpoint = true
hcp_vault_public_endpoint  = true

tags = {
  Environment = "hashicorp-stack-demoapp"
  Automation  = "terraform"
  Owner       = "ACME"
}
