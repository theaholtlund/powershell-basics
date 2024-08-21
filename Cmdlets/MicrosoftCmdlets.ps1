# Introduction to cmdlets in PowerShell, only works on Windows

# Get-Service function creates array of objects, used to print property of Service object
$Services = Get-Service 
$Services.DisplayName

# Get-Member function gives properties and methods for specified object
$Services | Get-Member

# New object with custom properties of Get-Service function
$MyObject = $Services | Select-Object -Property DisplayName, ServiceHandle, MachineName
$MyObject

# Substituting value of $Services variable in for $_
$Services | Where-Object {$_.DisplayName -match "Xbox"} 
