# Introduction to cmdlets in PowerShell, file is just for testing and learning

# Ask the user for their name
$Name = Read-Host "What is your name?"

# Print simple greeting to the console
Write-Host "Hello, $Name! Welcome to the PowerShell world."

# Ask the user for their age
$Age = Read-Host "How old are you?"

# Print message based on age of the user, using comparison operators
# Operator -le stands for "less than", and -ge stands for "greater than or equal to"
if ($Age -lt 18) {
    Write-Host "You are a minor."
} elseif ($Age -ge 18 -and $Age -lt 65) {
    Write-Host "You are an adult."
} else {
    Write-Host "You are a senior citizen."
}

# Concatenate strings in PowerShell
$Greeting = "Nice to meet you, $Name! You are $Age years old."

# Print the concatenated string
Write-Host $Greeting

# Get the current date and time
$CurrentDateTime = Get-Date

# Print the current date and time
Write-Host "The current date and time is: $CurrentDateTime"

# Create new directory, but only if one does not already exist
# -PathType Container specifies that the code is checking for a directory
$DirectoryPath = ".\NewDirectory"

if (-not (Test-Path -Path $DirectoryPath -PathType Container)) {
    New-Item -ItemType Directory -Path $DirectoryPath
    Write-Host "Directory '$DirectoryPath' created."
} else {
    Write-Host "Directory '$DirectoryPath' already exists."
}

# Check if a file exists in the newly created directory
$FilePath = ".\NewDirectory\test.txt"
if (Test-Path $FilePath) {
    Write-Host "The file $FilePath exists."
} else {
    Write-Host "The file $FilePath does not exist."
}
