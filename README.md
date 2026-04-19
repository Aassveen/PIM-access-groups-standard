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

## Configuring 8-Hour Eligibility Duration
After deployment, configure the 8-hour eligibility duration in the Azure Portal:

1. Go to **Azure AD > Privileged Identity Management > Azure AD roles**
2. Select each role (Global Reader, Global Administrator, etc.)
3. Click **Settings**
4. Under **Activation**, set **Maximum activation duration** to 8 hours
5. Save the settings

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
- Groups are permanently assigned to roles
- Users can activate their eligibility through the Azure Portal PIM interface
- Access packages provide self-service request workflows (when available)