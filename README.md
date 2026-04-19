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
- Permanent role assignments making each group eligible for its corresponding directory role
- An access package catalog named "PIM Access Packages"
- Access packages for each group, allowing self-service requests
- Assignment policies with self-service access for all directory members

## Prerequisites
- Azure AD tenant with Privileged Role Administrator or Global Administrator permissions
- Terraform >= 1.0
- Azure CLI logged in (`az login`)

## Deployment Steps
1. Clone this repository
2. Navigate to the project directory
3. Run `terraform init`
4. Run `terraform plan` to review changes
5. Run `terraform apply` to deploy

## Publishing to GitHub
1. Create a new repository on GitHub named "PIM-access-groups-standard" (public)
2. Add this repository as remote: `git remote add origin https://github.com/yourusername/PIM-access-groups-standard.git`
3. Push the code: `git push -u origin master`

## Notes
- Groups are permanently assigned to roles; PIM is managed at the group membership level
- Users can request access through the access packages in the My Access portal
- To enable PIM for group memberships, configure PIM settings in Azure portal after deployment