# This file contains functions for general note management in the PowerShell Notes Application

# Function to add a note to the $Notes ArrayList
Function Add-Note {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Note,
        [String]$Category
    )
    $Script:Notes.Add($Note) | Out-Null
    $Script:NotesCategories.Add($Category) | Out-Null
}

# Function to display all notes in the $Notes ArrayList
Function Show-Notes {
    Write-Output "Notes:"
    For ($i = 0; $i -lt $Script:Notes.Count; $i++) {
        Write-Output "$i - $($Script:Notes[$i]) - Category: $($Script:NotesCategories[$i])"
    }
}

# Function to remove a note from the $Notes array based on index
Function Remove-Note {
    $IndexToRemove = Read-Host "Enter the index of the note you want to remove"
    if ($IndexToRemove -eq "exit") {
        Exit-Script
    }
    if ($IndexToRemove -ge 0 -and $IndexToRemove -lt $Script:Notes.Count) {
        $Script:Notes.RemoveAt($IndexToRemove)
        $Script:NotesCategories.RemoveAt($IndexToRemove)
        Write-Output "Note at index $IndexToRemove removed."
    } else {
        Write-Output "Invalid index, note was not removed."
    }
}

# Function to edit a note in the $Notes ArrayList based on index
Function Edit-Note {
    param (
        [Parameter(Mandatory = $true)]
        [int]$Index
    )

    if ($Index -ge 0 -and $Index -lt $Script:Notes.Count) {
        $NewNote = Read-Host "Enter the new content for the note at index $Index"
        if ($NewNote -eq "exit") {
            Exit-Script
        }
        $Script:Notes[$Index] = $NewNote
        Write-Output "Note at index $Index edited."
    } else {
        Write-Output "Invalid index, note was not edited."
    }
}

# Function to clear all notes from the $Notes ArrayList
Function Clear-Notes {
    $Script:Notes.Clear()
    $Script:NotesCategories.Clear()
    Write-Output "All notes cleared."
}

# Function to search notes for a specific keyword
Function Search-Notes {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Keyword
    )

    # Check if the keyword exists in any notes
    $foundNotes = $Script:Notes | Where-Object { $_ -match $Keyword }

    # If any notes are found, display them
    if ($foundNotes) {
        Write-Output "Notes containing '$Keyword':"
        $foundNotes
    } 
    else {
        # If no notes are found, notify the user
        Write-Output "No notes containing the keyword '$Keyword' found."
    }
} 

# Function to handle script exit based on user input
Function Exit-Script {
    Write-Host "Bye for now, see you again later!" -ForegroundColor Yellow
    exit
}
