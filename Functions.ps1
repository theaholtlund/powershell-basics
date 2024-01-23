# Functions for the Notes Application

# Initialise storage array, @() represents empty array and $Script makes variable global in script
$Script:Notes = @()

# Function to add a note to the $Notes array
Function Add-Note {
    param (
        [String]$Note  # Note to be added, parameter $Note of type String
    )
    $Script:Notes += $Note   # Append Note to $Notes array
}
