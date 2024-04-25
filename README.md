# Remoteapp Connector 1.0
Windows 10/11 remoteapp connection script. 
This script can be used to create a GPO logon script for automaticlly create a remoteapp connction to your RD farm if you should run in the this issue here: 
https://techcommunity.microsoft.com/t5/windows-11/microsoft-rdp-problems-windows-11-22h2/m-p/3653483

# Preparation:

Save the Script: Save the script as Install-RDSWebFeed.ps1 in a central location that the domain controller can access.

Create a GPO: In the Group Policy Management Console (GPMC), create a new Group Policy Object (GPO).

# Configure the Logon Script:

a. In the GPO Editor, navigate to User Configuration > Policies > Windows Settings > Scripts > Logon Script.

b. Right-click Logon Script and select Add.

c. In the Add Script window, select the Script file option.

d. Browse to the location where you saved the Install-RDSWebFeed.ps1 script and select it.

e. Click Open and then OK.

# Additional Considerations:

Targeting: Determine the user or computer groups to which you want to apply the GPO to ensure the script runs only for the intended users.

Test the Script: Thoroughly test the script before deploying it in a production environment to avoid unintended consequences.

Documentation: Document the purpose, functionality, and configuration of the script to facilitate future maintenance.

# Alternatives:

Deployment via Configuration Manager or MDT: If you are using Microsoft System Center Configuration Manager (SCCM), you can also deploy the script using that platform.

Remote Script Management: Consider using remote script management tools like PowerShell Remoting or Windows Admin Center to execute the script on target systems.

Important: Ensure you have the necessary permissions to create and configure GPOs.
