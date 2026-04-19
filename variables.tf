variable "tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
  default     = "1fd7e0f3-8bdd-43e1-b81c-503044f52c8f"
}

variable "directory_roles" {
  description = "List of directory roles to create PIM groups for"
  type        = list(string)
  default = [
    "Global Reader",
    "Global Administrator",
    "SharePoint Administrator",
    "Exchange Administrator",
    "Teams Administrator",
    "Security Administrator",
    "Compliance Administrator"
  ]
}