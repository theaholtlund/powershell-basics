# Tests for functions in NotesFunctions.ps1

# Import required modules
Import-Module -Name Pester

# Import the code file containing the functions to test
BeforeAll {
    . $PSScriptRoot/../NotesFunctions.ps1
}

# Test suite for Add-Note function
Describe "Add-Note Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @()
        $Script:NotesCategories = @()
    }

    It "Adding a note with a specified category should add a note with the specified category to the notes and categories arrays" {
        Add-Note "Test Note" "TestCategory"
        $Notes[-1] -eq "Test Note" -and $NotesCategories[-1] -eq "TestCategory"
    }
}

# Test suite for Edit-Note function
Describe "Edit-Note Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @("Existing Note 1", "Existing Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Editing a note in the notes array should modify the note content at the specified index" {
        $Index = 0
        $NewContent = "Edited Note"
        Edit-Note -Index $Index
        $Notes[$Index] -eq $NewContent
    }
}

# Test suite for Remove-Note function
Describe "Remove-Note Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = New-Object System.Collections.ArrayList
        $Script:Notes.AddRange(("Existing Note 1", "Existing Note 2"))
        
        $Script:NotesCategories = New-Object System.Collections.ArrayList
        $Script:NotesCategories.AddRange(("Category A", "Category B"))
    }

    It "Removing a note from the notes array should remove the note and its category from the arrays" {
        $Index = 0
        Remove-Note -Index $Index
        ($Script:Notes -notcontains "Existing Note 1") -and ($Script:NotesCategories -notcontains "Category A")
    }

    It "Attempting to remove a note with an invalid index should not modify the notes or categories arrays" {
        $Index = -1
        Remove-Note -Index $Index
        ($Script:Notes.Count -eq 2) -and ($Script:NotesCategories.Count -eq 2)
    }
}


# Test suite for Clear-Notes function
Describe "Clear-Notes Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @("Existing Note 1", "Existing Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Clearing all notes from the notes array should remove all notes and categories from the notes and categories arrays" {
        Clear-Notes
        $Script:Notes.Count -eq 0 -and $Script:NotesCategories.Count -eq 0
    }
}

# Test suite for Search-Notes function
Describe "Search-Notes Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @("Test Note 1", "Test Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Searching for notes containing a specific keyword should return notes containing the specified keyword" {
        $Keyword = "Test"
        $FoundNotes = Search-Notes -Keyword $Keyword
        $FoundNotes -contains "Test Note 1" -and $FoundNotes -contains "Test Note 2"
    }

    It "Searching for notes containing a specific keyword should notify the user when no notes containing the keyword are found" {
        $Keyword = "Nonexistent"
        $NotFoundMessage = "No notes containing the keyword '$Keyword' found."
        $FoundNotes = Search-Notes -Keyword $Keyword
        $FoundNotes -eq $NotFoundMessage
    }
}

# Test suite for Export-Notes function
Describe "Export-Notes Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @("Test Note 1", "Test Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Exporting notes to a valid file path should create a file with all notes content" {
        $ExportPath = "/Users/theaholtlund"
        Export-Notes -Path $ExportPath
        $ExportedNotes = Get-Content -Path "$ExportPath\Notes.txt"
        $ExportedNotes -eq "Test Note 1`r`nTest Note 2"
    }

    It "Attempting to export notes to an invalid file path should display an error message" {
        $InvalidPath = "C:\Invalid\Path"
        Export-Notes -Path $InvalidPath | Should -BeNullOrEmpty
    }
}
