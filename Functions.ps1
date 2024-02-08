# This file only contains functions, later to be imported into other scripts for use
# Provides modularity and organization, enhancing readability and promoting separation of concerns

# Function to add note to the $Notes ArrayList
# Note to be added as parameter $Note, of type String, with Out-Null suppressing the output
Function Add-Note {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Note  
    )
    $Script:Notes.Add($Note) | Out-Null
}

# Function to display all notes in the $Notes ArrayList
Function Show-Notes {
    Write-Output "Notes:"
    For ($i = 0; $i -lt $Script:Notes.Count; $i++) {
        Write-Output "$i - $($Script:Notes[$i])"
    }
}

# Function to remove note from the $Notes array based on index
# Index of the note to be removed as parameter $Index, of type Int
Function Remove-Note {
    $IndexToRemove = Read-Host "Enter the index of the note you want to remove"
    if ($IndexToRemove -eq "exit") {
        Exit-Script
    }
    if ($IndexToRemove -ge 0 -and $IndexToRemove -lt $Script:Notes.Count) {
        $Script:Notes.RemoveAt($IndexToRemove)
        Write-Output "Note at index $IndexToRemove removed."
    } else {
        Write-Output "Invalid index, note was not removed."
    }
}

# Function to edit note in the $Notes ArrayList based on index
# Index of the note to be edited as parameter $Index, of type Int
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

# Function to export notes to a text file
# Test-Path to first check if all path elements exist, then if path syntax is correct
Function Export-Notes {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Path
    )
    if (-not (Test-Path -Path $Path -IsValid)) {
        Write-Output "Invalid path, please provide a valid file path." -ForegroundColor Red
        return
    }

    $NotesString = $Script:Notes -join "`r`n"
    $ExportFilePath = Join-Path -Path $Path -ChildPath "Notes.txt"
    $NotesString | Out-File -FilePath $ExportFilePath -Encoding utf8
    Write-Output "Notes were successfully exported to $ExportFilePath."
}

# Function to handle script exit based on user input
Function Exit-Script {
    Write-Output "Bye for now, see you again later!" -ForegroundColor Yellow
    exit
}
