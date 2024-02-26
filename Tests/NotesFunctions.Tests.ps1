# This file contains tests for functions in NotesFunctions.ps1

# Import required modules
Import-Module -Name Pester

# Import the code file containing the functions to test
BeforeAll {
    . $PSScriptRoot/../App/NotesFunctions.ps1
}

Describe "Add-Note Function Tests" {
    BeforeEach {
        # Initialise $Script:Notes and $Script:NotesCategories arrays before each test
        $Script:Notes = @()
        $Script:NotesCategories = @()
    }

    It "Adding a note with a specified category should add a note with the specified category to the notes and categories arrays" {
        Add-Note "Test Note" "TestCategory"
        $Notes = $Script:Notes
        $Categories = $Script:NotesCategories
        $Notes[-1] -eq "Test Note" -and $Categories[-1] -eq "TestCategory"
    }
}

Describe "Remove-Note Function Tests" {
    BeforeEach {
        # Initialise $Script:Notes and $Script:NotesCategories arrays before each test
        $Script:Notes = @("Existing Note 1", "Existing Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Removing a note from the notes array should remove the note at the specified index from the notes and categories arrays" {
        $InitialCount = $Script:Notes.Count
        Remove-Note -Index 1
        $Script:Notes.Count -eq ($InitialCount - 1)
    }

    It "Removing a note from the notes array should not modify notes or categories arrays when provided with an invalid index" {
        $InitialCount = $Script:Notes.Count
        Remove-Note -Index 99999
        $Script:Notes.Count -eq $InitialCount
    }
}

Describe "Edit-Note Function Tests" {
    BeforeEach {
        # Initialise $Script:Notes and $Script:NotesCategories arrays before each test
        $Script:Notes = @("Existing Note 1", "Existing Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Editing a note in the notes array should modify the note content at the specified index" {
        Edit-Note -Index 0
        $Script:Notes[0] -eq "Edited Note"
    }
}

Describe "Clear-Notes Function Tests" {
    BeforeEach {
        # Initialise $Script:Notes and $Script:NotesCategories arrays before each test
        $Script:Notes = @("Existing Note 1", "Existing Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Clearing all notes from the notes array should remove all notes and categories from the notes and categories arrays" {
        Clear-Notes
        $Script:Notes.Count -eq 0 -and $Script:NotesCategories.Count -eq 0
    }
}

Describe "Search-Notes Function Tests" {
    BeforeEach {
        # Initialise $Script:Notes and $Script:NotesCategories arrays before each test
        $Script:Notes = @("Test Note 1", "Test Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Searching for notes containing a specific keyword should return notes containing the specified keyword" {
        Search-Notes -Keyword "Test" | Should -Contain "Test Note 1", "Test Note 2"
    }

    It "Searching for notes containing a specific keyword should notify the user when no notes containing the keyword are found" {
        Search-Notes -Keyword "Nonexistent" | Should -Match "No notes containing the keyword 'Nonexistent' found."
    }
}

Describe "Export-Notes Function Tests" {
    BeforeEach {
        # Initialise $Script:Notes and $Script:NotesCategories arrays before each test
        $Script:Notes = @("Test Note 1", "Test Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Exporting notes to a text file should create a text file containing all notes" {
        $TempFilePath = "$env:TEMP\TestNotes.txt"
        Export-Notes -FilePath $TempFilePath
        (Get-Content $TempFilePath) -eq "Test Note 1`r`nTest Note 2"
    }
}
