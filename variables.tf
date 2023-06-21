variable "storage_class_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "reclaim_policy" {
  type    = string
  default = "Delete"
}

variable "directory_permission" {
  type    = string
  default = "700"
}

variable "lifecycle_policy_transition_to_ia" {
  type    = string
  default = "AFTER_30_DAYS"
}

variable "efs_backup_policy_status" {
  type    = string
  default = "ENABLED"
}

variable "security_groups" {
  type = list(string)
}
