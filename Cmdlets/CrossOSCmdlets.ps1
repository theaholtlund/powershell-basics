# Introduction to cmdlets in PowerShell

# Write out to the shell, ask the user for their name
$Name = Read-Host "What is your name?"

# Print simple greeting to the console
Write-Host "Hello, $Name! Welcome to the PowerShell world." -ForegroundColor DarkRed

# Ask the user for their age
$Age = Read-Host "How old are you?"

# Print message based on age of user, using comparison operators
If ($Age -lt 18) {
    Write-Host "You are a minor."
} ElseIf ($Age -ge 18 -and $Age -lt 65) {
    Write-Host "You are an adult."
} Else {
    Write-Host "You are a senior citizen."
}

# Concatenate strings in PowerShell
$Greeting = "Nice to meet you, $Name! You are $Age years old."

# Print the concatenated string
Write-Host $Greeting -ForegroundColor DarkYellow

# Get the current date and time in PowerShell
$CurrentDateTime = Get-Date

# Print the current date and time
Write-Host "The current date and time is: $CurrentDateTime"

# Create new directory, but only if one does not already exist
# -PathType Container specifies that the code is checking for a directory
$DirectoryPath = ".\NewDirectory"

If (-not (Test-Path -Path $DirectoryPath -PathType Container)) {
    New-Item -ItemType Directory -Path $DirectoryPath
    Write-Host "Directory '$DirectoryPath' created."
} Else {
    Write-Host "Directory '$DirectoryPath' already exists."
}

# Check if a file exists in the newly created directory
$FilePath = ".\NewDirectory\test.txt"
If (Test-Path $FilePath) {
    Write-Host "The file $FilePath exists."
} Else {
    Write-Host "The file $FilePath does not exist."
}

# Write text to a file
$TextToWrite = "This is some text that will be written to the file."
$TextToWrite | Out-File -FilePath $FilePath

# Read text from a file
$FileContent = Get-Content -Path $FilePath
Write-Host "Content of the file: $FileContent"

# Clean up testing by deleting the directory and its contents
Remove-Item -Path ".\NewDirectory" -Recurse -Force
Write-Host "Directory and its contents deleted."
