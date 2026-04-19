variable "tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
  default     = "1fd7e0f3-8bdd-43e1-b81c-503044f52c8f"
}

variable "directory_roles" {
  description = "Map of directory role display names to their template IDs"
  type        = map(string)
  default = {
    "Global Reader"          = "f2ef992c-3afb-46b9-b7cf-a126ee74c451"
    "Global Administrator"   = "62e90394-69f5-4237-9190-012177145e10"
    "SharePoint Administrator" = "f28a1f50-f6e7-4571-818b-6a12f2af6b6c"
    "Exchange Administrator" = "29232cdf-9323-42fd-ade2-1d097af3e4de"
    "Teams Administrator"    = "69091246-20e8-4a56-aa4d-066075b2a7a8"
    "Security Administrator" = "194ae4cb-b126-40b2-bd5b-6091b380977d"
    "Compliance Administrator" = "17315797-102d-40b4-93e0-432062caca18"
  }
}