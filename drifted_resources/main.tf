terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "2.2.0"
    }
  }
}

data "scalr_current_account" "data_acc" {}

output "out_acc" {
  value = yamlencode(data.scalr_current_account.data_acc)
}

resource "scalr_environment" "dana_env" {
  count      = 1
  name       = "test-env-${count.index}"
  account_id = data.scalr_current_account.data_acc.id
}

output "out_env" {
  value = scalr_environment.dana_env[*].id
}

resource "scalr_iam_team" "team" {
  name        = "team-${count.index}"
  count       = 2
  description = "bug fix"
  account_id  = data.scalr_current_account.data_acc.id
}

resource "scalr_variable" "var_terraform" {
  count      = 1
  key        = "var-${count.index}"
  value      = "TRACE"
  category   = "terraform"
  account_id = data.scalr_current_account.data_acc.id
}

resource "scalr_variable" "var_shell" {
  key        = "key1"
  value      = "1"
  category   = "shell"
  account_id = data.scalr_current_account.data_acc.id
}