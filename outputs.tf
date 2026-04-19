output "pim_group_ids" {
  description = "Object IDs of the created PIM groups"
  value       = { for k, v in azuread_group.pim_groups : k => v.object_id }
}

output "access_package_ids" {
  description = "IDs of the created access packages"
  value       = { for k, v in azuread_access_package.pim_access_packages : k => v.id }
}

output "catalog_id" {
  description = "ID of the access package catalog"
  value       = azuread_access_package_catalog.pim_catalog.id
}