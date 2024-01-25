# Introduction to cmdlets in PowerShell, file is just for testing and learning

# Ask the user for their name
$Name = Read-Host "What is your name?"

# Print a simple greeting to the console
Write-Host "Hello, $Name! Welcome to the PowerShell world."

# Ask the user for their age
$Age = Read-Host "How old are you?"

# Print a message based on age of the user, using comparison operators
# Operator -le stands for "less than", and -ge stands for "greater than or equal to"
if ($Age -lt 18) {
    Write-Host "You are a minor."
} elseif ($Age -ge 18 -and $Age -lt 65) {
    Write-Host "You are an adult."
} else {
    Write-Host "You are a senior citizen."
}
