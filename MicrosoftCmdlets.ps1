# Introduction to cmdlets in PowerShell, file is just for testing and learning

# Define variable, all variables have $ in front
# Get-Service function creates array of objects, used to print property of Service object
$Services = Get-Service 
$Services.DisplayName

# All PowerShell functions have a file listing its properties
# Get-Member function gives properties and methods for specified object
$Services | Get-Member

# New object with custom properties of Get-Service function, and display content of variable
$MyObject = $Services | Select-Object -Property DisplayName, ServiceHandle, MachineName
$MyObject

# Substituting value of $Services variable in for $_
$Services | Where-Object {$_.DisplayName -match "Xbox"} 
