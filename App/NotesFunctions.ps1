# This file contains functions for general note management in the PowerShell Notes Application

# Function to add a note to the $Notes ArrayList
Function Add-Note {
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Note,
        [String]$Category
    )

    # Initialise Notes and NotesCategories if they are null
    If (-not $Script:Notes) {
        $Script:Notes = New-Object System.Collections.ArrayList
    }
    If (-not $Script:NotesCategories) {
        $Script:NotesCategories = New-Object System.Collections.ArrayList
    }

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
    Param (
        [Parameter(Mandatory = $true)]
        [int]$Index
    )

    If ($Index -ge 0 -and $Index -lt $Script:Notes.Count) {
        $Script:Notes.RemoveAt($Index)
        $Script:NotesCategories.RemoveAt($Index)
        Write-Output "Note at index $Index removed."
    } Else {
        Write-Output "Invalid index, note was not removed."
    }
}

# Function to edit a note in the $Notes ArrayList based on index
Function Edit-Note {
    Param (
        [Parameter(Mandatory = $true)]
        [int]$Index
    )

    If ($Index -ge 0 -and $Index -lt $Script:Notes.Count) {
        $NewNote = Read-Host "Enter the new content for the note at index $Index"
        $Script:Notes[$Index] = $NewNote
        Write-Output "Note at index $Index edited."
    } Else {
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
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Keyword
    )

    # Check if the keyword exists in any notes
    $FoundNotes = $Script:Notes | Where-Object { $_ -match $Keyword }

    # Return the found notes
    $FoundNotes
}

# Function to export notes to a text file
Function Export-Notes {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Path
    )
    If (-not (Test-Path -Path $Path -IsValid)) {
        Write-Host "Invalid path, please provide a valid file path." -ForegroundColor Red
        return
    }

    $NotesString = $Script:Notes -join "`r`n"
    $ExportFilePath = Join-Path -Path $Path -ChildPath "Notes.txt"
    $NotesString | Out-File -FilePath $ExportFilePath -Encoding utf8
    Write-Output "Notes were successfully exported to $ExportFilePath."
}
