# This file only contains functions, later to be imported into other scripts for use
# Provides modularity and organisation, enhancing readability and promoting separation of concerns

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
    $IndexToRemove = Read-Host "Enter the index of the note you want to remove."
    if ($IndexToRemove -ge 0 -and $IndexToRemove -lt $Script:Notes.Count) {
        $Script:Notes.RemoveAt($IndexToRemove)
        Write-Host "Note at index $IndexToRemove removed."
    } else {
        Write-Host "Invalid index, note was not removed."
    }
}

# Function to clear all notes from the $Notes ArrayList
Function Clear-Notes {
    $Script:Notes.Clear()
    Write-Host "All notes cleared."
}

# Function to search notes for a specific keyword
Function Search-Notes {
    param (
        [String]$Keyword
    )
    $foundNotes = $Script:Notes | Where-Object { $_ -match $Keyword }
    if ($foundNotes) {
        Write-Host "Notes containing '$Keyword':"
        $foundNotes
    } else {
        Write-Host "No notes containing '$Keyword' found."
    }
}
