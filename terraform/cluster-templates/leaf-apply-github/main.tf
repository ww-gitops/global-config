provider "github" {
  owner = var.github_owner
  token = var.github_token
}

locals {
  gid = format("\"%s\"", var.awsTagProjectGid)
  awsAccount = format("\"%s\"", var.awsAccountId)
}

resource "github_repository_file" "global_config" {
  repository          = var.repository_name
  branch              = var.globalGitHubBranch
  file                = format("%s/%s/global-config.yaml", var.target_path, var.flux_sync_directory)
  content = templatefile("${path.module}/templates/gitrepository.tftpl", {
    name       = "global-config"
    namespace  = var.template_namespace
    globalGitHubOrg = var.globalGitHubOrg
    globalGitHubRepo = var.globalGitHubRepo
    globalGitHubBranch = var.globalGitHubBranch
  })
  commit_author       = var.git_commit_author
  commit_email        = var.git_commit_email
  commit_message      = var.git_commit_message
  overwrite_on_create = true
}

resource "github_repository_file" "leaf_config" {
  repository          = var.repository_name
  branch              = var.globalGitHubBranch
  file                = format("%s/%s/wge-leaf-config.yaml", var.target_path, var.flux_sync_directory)
  content = templatefile("${path.module}/templates/kustomization.tftpl", {
    name       = "wge-leaf-config"
    namespace  = var.template_namespace
    path       = "./leaf-clusters/wge-leaf-config"
    wait       = true
    timeout    = "5m"
    depends_on = []
    config     = null
    substitute = <<-EOF
      clusterName: ${var.cluster_name}
      GitHubOrg: ${var.github_owner}
      GitHubRepo: ${var.repository_name}
      userEmail: ${var.git_commit_email}
      commitUser: ${var.git_commit_author}
      resourceName: ${var.resource_name}
      templateNamespace: ${var.template_namespace}
      prefixName: ${var.prefixName}
      globalGitHubOrg: ${var.globalGitHubOrg}
      globalGitHubRepo: ${var.globalGitHubRepo}
      globalGitHubBranch: ${var.globalGitHubBranch}
      awsAccountId: ${local.awsAccount}
      awsRegion: ${var.awsRegion}
      awsTagCreator: ${var.awsTagCreator}
      awsTagCustomer: ${var.awsTagCustomer}
      awsTagProjectGid: ${local.gid}
    EOF
  })
  commit_author       = var.git_commit_author
  commit_email        = var.git_commit_email
  commit_message      = var.git_commit_message
  overwrite_on_create = true
}

resource "github_repository_file" "leaf-addons" {
  repository          = var.repository_name
  branch              = var.globalGitHubBranch
  file                = format("%s/%s/wge-leaf.yaml", var.target_path, var.flux_sync_directory)
  content = templatefile("${path.module}/templates/kustomization.tftpl", {
    name       = "wge-leaf"
    namespace  = var.template_namespace
    path       = "./leaf-clusters/wge-leaf"
    wait       = true
    timeout    = "5m"
    depends_on = ["wge-leaf-config"]
    config     = true
    substitute = null
  })
  commit_author       = var.git_commit_author
  commit_email        = var.git_commit_email
  commit_message      = var.git_commit_message
  overwrite_on_create = true
}

resource "github_repository_file" "leaf-apps" {
  repository          = var.repository_name
  branch              = var.globalGitHubBranch
  file                = format("%s/%s/wge-leaf-apps.yaml", var.target_path, var.flux_sync_directory)
  content = templatefile("${path.module}/templates/kustomization.tftpl", {
    name       = "wge-leaf-apps"
    namespace  = var.template_namespace
    path       = "./leaf-clusters/wge-leaf-apps"
    wait       = true
    timeout    = "5m"
    depends_on = ["wge-leaf"]
    config     = true
    substitute = null
  })
  commit_author       = var.git_commit_author
  commit_email        = var.git_commit_email
  commit_message      = var.git_commit_message
  overwrite_on_create = true
}
