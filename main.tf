data "azuread_directory_roles" "all" {}

locals {
  role_ids = {
    for role in data.azuread_directory_roles.all.roles : role.display_name => role.object_id
  }
}

# Create PIM groups for each directory role
resource "azuread_group" "pim_groups" {
  for_each = var.directory_roles

  display_name       = "PIM-${each.key}-Tilgang"
  security_enabled   = true
  assignable_to_role = true
}

# Assign each role to the corresponding group (permanent assignment for PIM setup)
resource "azuread_directory_role_assignment" "pim_assignments" {
  for_each = azuread_group.pim_groups

  role_id             = var.directory_roles[each.key]
  principal_object_id = each.value.object_id
}

# Make each group eligible for the corresponding role with 8-hour duration
resource "azuread_directory_role_eligibility_schedule_request" "pim_eligibility" {
  for_each = azuread_group.pim_groups

  role_definition_id = var.directory_roles[each.key]
  principal_id       = each.value.object_id
  directory_scope_id = "/"
  justification      = "Terraform-managed PIM eligibility for ${each.key} role with 8-hour duration"
}

# Static time for schedule start
resource "time_static" "start" {}

# Create access package catalog
resource "azuread_access_package_catalog" "pim_catalog" {
  display_name = "PIM Access Packages"
  description  = "Catalog for PIM access packages to directory roles"
}

# Associate each group as a resource in the catalog
resource "azuread_access_package_resource_catalog_association" "group_associations" {
  for_each = azuread_group.pim_groups

  catalog_id             = azuread_access_package_catalog.pim_catalog.id
  resource_origin_id     = each.value.object_id
  resource_origin_system = "AadGroup"
}

# Create access package for each group
resource "azuread_access_package" "pim_access_packages" {
  for_each = azuread_group.pim_groups

  catalog_id   = azuread_access_package_catalog.pim_catalog.id
  display_name = "PIM ${each.key} Access Package"
  description  = "Self-service access to PIM group for ${each.key} role"
}

# Link each group resource to its access package
resource "azuread_access_package_resource_package_association" "group_access" {
  for_each = azuread_access_package.pim_access_packages

  access_package_id               = each.value.id
  catalog_resource_association_id = azuread_access_package_resource_catalog_association.group_associations[each.key].id
  access_type                     = "Member"
}

# Create self-service assignment policy for each access package
resource "azuread_access_package_assignment_policy" "self_service_policies" {
  for_each = azuread_access_package.pim_access_packages

  access_package_id = each.value.id
  display_name      = "Self-service PIM ${each.key} Access"
  description       = "Self-service policy for requesting access to ${each.key} PIM group"

  requestor_settings {
    scope_type = "AllExistingDirectoryMemberUsers"
  }
}