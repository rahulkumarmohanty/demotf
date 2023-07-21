location                 = "East US"
name                     = "gbeirhgkshlbvjs"
resource_group_create    = true
resource_group_name      = "RG2"
access_tier              = "Hot"
account_kind             = "StorageV2"
account_replication_type = "LRS"
account_tier             = "Standard"
containers = [
  {
    name        = "container1"
    access_type = "private"
  },
  {
    name        = "container2"
    access_type = "container"
  }
]
soft_delete_retention = 25
tags = {
  "name" = "dev"
}
