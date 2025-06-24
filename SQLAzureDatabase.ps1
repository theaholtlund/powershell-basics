# Draft and placeholders for ideas on setup

[CmdletBinding()]
Param(
    [Parameter()]
    [Switch]$LocalTest,

    [Parameter()]
    [String]$Environment = "Test"
)

# Set strict error handling
$ErrorActionPreference = "Stop"
$WarningPreference = "SilentlyContinue"

# Load environment style config file
$EnvFile = ".databaseconfig"
Get-Content $EnvFile | ForEach-Object {
    if ($_ -match '^\s*([^#][^=]*)=(.*)$') {
        $Key = $matches[1].Trim()
        $Value = $matches[2].Trim()
        [System.Environment]::SetEnvironmentVariable($Key, $Value)
    }
}

# Retrieve environment variables
$Script:ResourceGroup         = $Env:RESOURCE_GROUP
$Script:SubscriptionID        = $Env:SUBSCRIPTION_ID
$Script:DatabaseName          = $Env:DATABASE_NAME
$Script:ConnectionAddress     = $Env:CONNECTION_ADDRESS
$Script:ClientID              = $Env:CLIENT_ID
$Script:ServiceUser           = $Env:SP_PASSWORD
$Script:TenantID              = $Env:TENANT_ID
$Script:ServicePrincipalName  = $Env:SERVICE_PRINCIPAL_NAME

# Import required modules
Write-Output "Importing required modules..."
Import-Module Az.Accounts, Az.Sql, Az.Resources -ErrorAction Stop
Import-Module SqlServer -ErrorAction Stop

Try {
# Azure login using Service Principal
$Script:SecurePassword = ConvertTo-SecureString $Script:ServiceUser -AsPlainText -Force
$Script:Credential = New-Object System.Management.Automation.PSCredential ($Script:ClientID, $SecurePassword)

Connect-AzAccount -ServicePrincipal -Credential $Credential -Tenant $Script:TenantID
Set-AzContext -SubscriptionId $Script:SubscriptionID -ErrorAction Stop

$ServicePrincipal = Get-AzADServicePrincipal -ApplicationId $Script:ClientID
$ServicePrincipalName = $ServicePrincipal.DisplayName

Write-Output "Logged into Azure as SP: $ServicePrincipalName"

# Prepare SQL connection string
$ConnectionString = @"
Server=$($Script:ConnectionAddress),1433;
Database=$($Script:DatabaseName);
Authentication=Active Directory Password;
User ID=$($Script:ClientID);
Password=$($Script:SecureSecret);
Encrypt=True;
TrustServerCertificate=False;
"@

# Create user in the specified database
$CreateUserQuery = @"
CREATE USER [$ServicePrincipalName] FROM EXTERNAL PROVIDER;
ALTER ROLE db_owner ADD MEMBER [$ServicePrincipalName];
"@

Write-Output "Creating AAD user '$ServicePrincipalName' with db_owner role in database '$DatabaseName'..."

Invoke-Sqlcmd -ConnectionString $ConnectionString -Query $CreateUserQuery -ErrorAction Stop

Write-Output "User '$ServicePrincipalName' created with db_owner role."
}

Catch {
    Write-Error "Failed to create user: $($_.Exception.Message)"
    Exit 1
}
