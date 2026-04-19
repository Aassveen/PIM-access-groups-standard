# PIM Access Groups Terraform Project

This Terraform project creates PIM (Privileged Identity Management) groups and self-service access packages for specific Entra ID directory roles.

## Roles Covered
- Global Reader
- Global Administrator
- SharePoint Administrator
- Exchange Administrator
- Teams Administrator
- Security Administrator
- Compliance Administrator

## Resources Created
- Security groups named `PIM-{Role}-Tilgang` for each role, configured as role-assignable
- PIM eligibility schedules making each group eligible for its corresponding directory role
- An access package catalog named "PIM Access Packages"
- Access packages for each group, allowing self-service requests
- Assignment policies with 30-day expiration and no approval required

## Prerequisites
- Azure AD tenant with Privileged Role Administrator or Global Administrator permissions
- Terraform >= 1.0
- Azure CLI logged in (`az login`)

## Usage
1. Clone this repository
2. Navigate to the project directory
3. Run `terraform init`
4. Run `terraform plan` to review changes
5. Run `terraform apply` to deploy

## Notes
- Groups are made eligible for roles via PIM, not permanently assigned
- Users can request access through the access packages in the My Access portal
- Eligibility duration is set to 1 year; assignment duration is 30 days