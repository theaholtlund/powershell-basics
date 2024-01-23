# Functions for the Notes Application

# Initialise storage array, @() represents empty array and $Script makes variable global in script
$Script:Notes = @()

# Function to add a note to the $Notes array
# Note to be added as parameter $Note, of type String
Function Add-Note {
    param (
        [String]$Note  
    )
    $Script:Notes += $Note
}

# Function to display all notes in the $Notes array
Function Show-Notes {
    Write-Host "Notes:"
    ForEach ($note in $Script:Notes) {
        Write-Host "- $Note"
    }
}
