# Load environment variables from environment file
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
