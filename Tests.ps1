# This file contains tests for functions in NotesFunctions.ps1
# Responsible for ensuring the functionality of functions in the PowerShell Notes Application

# Import required modules
Import-Module -Name Pester

# Import the functions from NotesFunctions.ps1 and Categories.ps1
BeforeAll {
    . "$PSScriptRoot/NotesFunctions.ps1"
    . "$PSScriptRoot/Categories.ps1"
}

Describe 'Add-Note Function Tests' {
    It 'Adding a note with a specified category should add a note with the specified category to the notes and categories arrays' {
        Add-Note "Test Note" "TestCategory"
        $Notes = $Script:Notes
        $Categories = $Script:NotesCategories
        $Notes[-1] -eq "Test Note" -and $Categories[-1] -eq "TestCategory"
    }
}

Describe 'Remove-Note Function Tests' {
    It 'Removing a note from the notes array should remove the note at the specified index from the notes and categories arrays' {
        $InitialCount = $Script:Notes.Count
        Add-Note "Test Note" "TestCategory"
        Remove-Note ($Script:Notes.Count - 1)
        $Script:Notes.Count -eq $InitialCount
    }

    It 'Removing a note from the notes array should not modify notes or categories arrays when provided with an invalid index' {
        $InitialCount = $Script:Notes.Count
        Remove-Note -Index 99999
        $Script:Notes.Count -eq $InitialCount
    }
}

Describe 'Edit-Note Function Tests' {
    It 'Editing a note in the notes array should modify the note content at the specified index' {
        Add-Note "Test Note" "TestCategory"
        Edit-Note -Index ($Script:Notes.Count - 1)
        $Script:Notes[-1] -eq "Edited Note"
    }
}

Describe 'Clear-Notes Function Tests' {
    It 'Clearing all notes from the notes array should remove all notes and categories from the notes and categories arrays' {
        Add-Note "Test Note 1" "TestCategory"
        Add-Note "Test Note 2" "TestCategory"
        Clear-Notes
        $Script:Notes.Count -eq 0 -and $Script:NotesCategories.Count -eq 0
    }
}

Describe 'Search-Notes Function Tests' {
    It 'Searching for notes containing a specific keyword should return notes containing the specified keyword' {
        Add-Note "Test Note 1" "TestCategory"
        Add-Note "Test Note 2" "TestCategory"
        Search-Notes -Keyword "Test" | Should -Contain "Test Note 1", "Test Note 2"
    }

    It 'Searching for notes containing a specific keyword should notify the user when no notes containing the keyword are found' {
        Search-Notes -Keyword "Nonexistent" | Should -Match "No notes containing the keyword 'Nonexistent' found."
    }
}

# Additional tests for Export-Notes function
Describe 'Export-Notes Function Tests' {
    It 'Exporting notes to a text file should create a text file containing all notes' {
        Add-Note "Test Note 1" "TestCategory"
        Add-Note "Test Note 2" "TestCategory"
        Export-Notes -FilePath "$env:TEMP\TestNotes.txt"
        (Get-Content "$env:TEMP\TestNotes.txt") -eq "Test Note 1`r`nTest Note 2"
    }
}
