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
- PIM eligibility schedules making each group **eligible** (not permanent) for its corresponding directory role
- Users must activate the role each time they need access

## Post-Deployment Configuration: Set Activation Duration

After deployment, configure the maximum activation duration in Azure Portal:

1. Go to **Azure AD > Privileged Identity Management > Azure AD roles**
2. Select each role (Global Reader, Global Administrator, etc.)
3. Click **Settings**
4. Set **Maximum activation duration** to **8 hours** (or your preferred duration)
5. Save

Now users must activate their eligibility and can hold the role for a maximum of 8 hours per activation.

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