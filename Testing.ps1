# This file contains tests for functions in NotesFunctions.ps1
# Responsible for ensuring the functionality of functions in the PowerShell Notes Application

# Import the functions script to be tested
. ".\Categories.ps1"
. ".\NotesFunctions.ps1"

# Import required modules
Import-Module -Name Pester

# Describe block for testing Add-Note function
Describe "Add-Note Function Tests" {
    Context "Adding a note with a specified category" {
        It "Should add a note with the specified category to the notes and categories arrays" {
            # Arrange
            $ExpectedNote = "Test Note"
            $ExpectedCategory = "Test Category"

            # Act
            Add-Notes -Note $ExpectedNote -Category $ExpectedCategory

            # Assert
            $AddedNote = $Script:Notes[-1]
            $AddedCategory = $Script:Categories[-1]
            $AddedNote | Should -Be $ExpectedNote
            $AddedCategory | Should -Be $ExpectedCategory
        }
    }
}

# Describe block for testing Remove-Note function
Describe "Remove-Note Function Tests" {
    Context "Removing a note from the notes array" {
        It "Should remove the note at the specified index from the notes and categories arrays" {
            # Arrange
            $ExpectedNote = "Test Note"
            $ExpectedCategory = "Test Category"
            Add-Note -Note $ExpectedNote -Category $ExpectedCategory

            # Act
            Remove-Note

            # Assert
            $Script:Notes | Should -NotContain $ExpectedNote
            $Script:Categories | Should -NotContain $ExpectedCategory
        }

        It "Should not modify notes or categories arrays when provided with an invalid index" {
            # Arrange
            $InitialNotesCount = $Script:Notes.Count
            $InitialCategoriesCount = $Script:Categories.Count

            # Act
            Remove-Note

            # Assert
            $Script:Notes.Count | Should -Be $InitialNotesCount
            $Script:Categories.Count | Should -Be $InitialCategoriesCount
        }
    }
}

# Describe block for testing Edit-Note function
Describe "Edit-Note Function Tests" {
    Context "Editing a note in the notes array" {
        It "Should modify the note content at the specified index" {
            # Arrange
            $ExpectedNote = "Test Note"
            Add-Note -Note $ExpectedNote
            $NewContent = "Edited Note Content"

            # Act
            Edit-Note 0

            # Assert
            $Script:Notes[0] | Should -Be $NewContent
        }
    }
}

# Describe block for testing Clear-Notes function
Describe "Clear-Notes Function Tests" {
    Context "Clearing all notes from the notes array" {
        It "Should remove all notes and categories from the notes and categories arrays" {
            # Arrange
            Add-Note -Note "Test Note 1" -Category "Test Category 1"
            Add-Note -Note "Test Note 2" -Category "Test Category 2"

            # Act
            Clear-Notes

            # Assert
            $Script:Notes | Should -BeNullOrEmpty
            $Script:Categories | Should -BeNullOrEmpty
        }
    }
}

# Describe block for testing Search-Notes function
Describe "Search-Notes Function Tests" {
    Context "Searching for notes containing a specific keyword" {
        It "Should return notes containing the specified keyword" {
            # Arrange
            Add-Note -Note "This is a test note"
            Add-Note -Note "Another test note"
            $Keyword = "test"

            # Act
            $Result = Search-Notes -Keyword $Keyword

            # Assert
            $Result | Should -Contain "This is a test note"
            $Result | Should -Contain "Another test note"
        }

        It "Should notify the user when no notes containing the keyword are found" {
            # Arrange
            $Keyword = "nonexistent"

            # Act
            $Result = Search-Notes -Keyword $Keyword

            # Assert
            $Result | Should -Contain "No notes containing the keyword '$Keyword' found."
        }
    }
}

# Describe block for testing Export-Notes function
Describe "Export-Notes Function Tests" {
    Context "Exporting notes to a text file" {
        It "Should create a text file containing all notes" {
            # Arrange
            Add-Note -Note "Test Note 1" -Category "Test Category 1"
            Add-Note -Note "Test Note 2" -Category "Test Category 2"
            $ExportPath = "/Users/theaholtlund/Documents"

            # Act
            Export-Notes -Path $ExportPath

            # Assert
            $ExportFilePath = Join-Path -Path $ExportPath -ChildPath "Notes.txt"
            Test-Path $ExportFilePath | Should -Be $True
            $ExportedContent = Get-Content $ExportFilePath
            $ExportedContent | Should -Contain "Test Note 1"
            $ExportedContent | Should -Contain "Test Note 2"
        }
    }
}
