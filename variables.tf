variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "access_tier" {
  type = string
}

variable "account_kind" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "containers" {
  type = list(object({
    name        = string
    access_type = string
  }))
}

variable "resource_group_create" {
  type = bool
}

variable "soft_delete_retention" {
  type = number
}

variable "tags" {
  type = map(string)
}
