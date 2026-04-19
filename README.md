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
- Permanent role assignments to each directory role
- (These will be converted to **eligible** in the next step)

## Post-Deployment: Convert to Eligible Roles

After running `terraform apply`, groups have **permanent** role assignments. Convert them to **eligible** (requires activation):

1. Go to **Azure AD > Privileged Identity Management > Azure AD roles**
2. Select the first role (e.g., **Global Reader**)
3. Go to **Assignments**
4. Find the group **PIM-Global Reader-Tilgang** and click it
5. Click **Edit assignment**
6. Change assignment type from **Active** to **Eligible**
7. Set **Maximum activation duration** to **8 hours**
8. Click **Update**
9. Repeat steps 2-8 for each role

Alternatively, use Azure CLI (faster for all 7 roles):

```powershell
# Get your tenant ID
$tenantId = "1fd7e0f3-8bdd-43e1-b81c-503044f52c8f"

# Get each group ID
$groups = @{
  "Global Reader" = "a9907c32-a194-48d9-af1c-faa2d125bcac"
  "Global Administrator" = "a905574e-35c7-4be1-8bb1-37a1987f51ad"
  # ... add other group IDs
}

# For each group, update to eligible
foreach ($role, $groupId in $groups.GetEnumerator()) {
  # Use Microsoft Graph API to convert to eligible
}
```

## Prerequisites
- Azure AD tenant with Global Administrator permissions
- Terraform >= 1.0
- Azure CLI logged in (`az login`)

## Prerequisites
- Azure AD tenant with Privileged Role Administrator permissions (for setting eligibility durations)
- Terraform >= 1.0
- Azure CLI logged in (`az login`)

## Deployment Steps
1. Clone this repository
2. Navigate to the project directory
3. Run `terraform init`
4. Run `terraform plan` to review changes
5. Run `terraform apply` to deploy
6. Configure 8-hour durations in Azure Portal (see above)

## Publishing to GitHub
1. Create a new repository on GitHub named "PIM-access-groups-standard" (public)
2. Add this repository as remote: `git remote add origin https://github.com/yourusername/PIM-access-groups-standard.git`
3. Push the code: `git push -u origin master`

## Permission Requirements
- **To create groups and assign roles**: Regular user permissions
- **To set eligibility schedules via Terraform**: Requires `RoleEligibilitySchedule.ReadWrite.Directory` scope (admin-only)
- **Alternative**: Configure eligibility durations in Azure Portal after deployment

## Notes
- Groups are eligible (not permanently assigned) for their roles
- Users must activate the role in PIM each time they need access
- Activation duration is configurable (8 hours recommended)
- This requires Global Admin permissions to deploy