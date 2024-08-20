# Working with users, only works on Windows

# Retrieve current user identity
$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
Write-Output $CurrentUser

# Convert current user identity to WindowsPrincipal
$Principal = New-Object System.Security.Principal.WindowsPrincipal($CurrentUser)
Write-Output $Principal

# Retrieve the Administrator role
$Role = [System.Security.Principal.WindowsBuiltInRole]::Administrator
Write-Output $Role

# Check if the current user is in the Administrator role
$Admin = $Principal.IsInRole($Role)

# Output the result
If ($Admin) {
    Write-Output "The current user is an Administrator."
} Else {
    Write-Output "The current user is not an Administrator."
}