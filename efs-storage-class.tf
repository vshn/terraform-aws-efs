resource "aws_efs_file_system" "efs" {
  encrypted = "true"

  tags = {
    Name = var.cluster_name
  }

  lifecycle_policy {
    transition_to_ia = var.lifecycle_policy_transition_to_ia
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id

  backup_policy {
    status = var.efs_backup_policy_status
  }
}

resource "aws_efs_mount_target" "efs_mount_target" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_groups
}

resource "kubernetes_storage_class_v1" "efs_storage_class" {
  metadata {
    name = var.storage_class_name
  }
  storage_provisioner = "efs.csi.aws.com"
  reclaim_policy      = var.reclaim_policy
  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId     = aws_efs_file_system.efs.id
    directoryPerms   = var.directory_permission
  }
}
