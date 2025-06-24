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
$Script:ResourceGroup       = $Env:RESOURCE_GROUP
$Script:SubscriptionID      = $Env:SUBSCRIPTION_ID
$Script:DatabaseName        = $Env:DATABASE_NAME
$Script:ManagedInstanceName = $Env:MANAGED_INSTANCE_NAME
$Script:ClientID            = $Env:CLIENT_ID
$Script:ServiceUser         = $Env:SP_PASSWORD
$Script:TenantID            = $Env:TENANT_ID
$Script:ConnectionString    = $Env:MANAGED_INSTANCE_NAME

# --- MODULE IMPORTS ---
Write-Output "Importing required modules..."
Import-Module Az.Accounts, Az.Sql, Az.Resources -ErrorAction Stop
Import-Module SqlServer -ErrorAction Stop
