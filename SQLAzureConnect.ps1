# Load environment variables from environment file
# Current setup requires Global Secure Access to be enabled
$EnvFile = ".sqlconfig"
Get-Content $EnvFile | ForEach-Object {
    If ($_ -match '^\s*([^#][^=]*)=(.*)$') {
        $Key = $matches[1].Trim()
        $Value = $matches[2].Trim()
        [System.Environment]::SetEnvironmentVariable($Key, $Value)
    }
}

# Retrieve environment variables
$DatabaseName = $Env:DATABASE_NAME
$ServerName = $Env:SERVER_NAME
$Username = $Env:SQL_USERNAME
$Password = $Env:SQL_PASSWORD

# Build connection string
$ConnectionString = "Server=$ServerName;Database=$DatabaseName;User ID=$Username;Password=$Password;Encrypt=True;TrustServerCertificate=True;Connection Timeout=30;"

# Use the .NET SqlClient to query
Add-Type -AssemblyName "System.Data"

$Connection = New-Object System.Data.SqlClient.SqlConnection
$Connection.ConnectionString = $ConnectionString
$Connection.Open()

$Command = $Connection.CreateCommand()
$Command.CommandText = "SELECT TOP 10 * FROM sys.tables"

$Reader = $Command.ExecuteReader()

While ($Reader.Read()) {
    Write-Output $Reader["Name"]
}

$Reader.Close()
$Connection.Close()
