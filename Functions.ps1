# Functions for the Notes Application

# Creating a new instance of ArrayList, allowing users to add and remove elements dynamically
$Script:Notes = New-Object System.Collections.ArrayList

# Function to add a note to the $Notes ArrayList
# Note to be added as parameter $Note, of type String, with Out-Null suppressing the output
Function Add-Note {
    param (
        [String]$Note  
    )
    $Script:Notes.Add($Note) | Out-Null
}

# Function to display all notes in the $Notes ArrayList
Function Show-Notes {
    Write-Host "Notes:"
    For ($i = 0; $i -lt $Script:Notes.Count; $i++) {
        Write-Host "$i - $($Script:Notes[$i])"
    }
}

# Function to remove a note from the $Notes array based on its index
# Index of the note to be removed as parameter $Index, of type Int
Function Remove-Note {
    $IndexToRemove = Read-Host "Enter the index of the note you want to remove"
    if ($IndexToRemove -ge 0 -and $IndexToRemove -lt $Script:Notes.Count) {
        $Script:Notes.RemoveAt($IndexToRemove)
        Write-Host "Note at index $IndexToRemove removed."
    } else {
        Write-Host "Invalid index. Note not removed."
    }
}

# Adding example notes to the array
Add-Note "This is the first note."
Add-Note "Learning PowerShell basics."
Add-Note "This is a cool and important note."

# Displaying all notes in the array
Show-Notes

# Removing a note from the array based on user input
Remove-Note

# Displaying notes after removing one
Show-Notes
