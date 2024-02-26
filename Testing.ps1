# This file contains tests for functions in Functions.ps1
# Responsible for ensuring the functionality of functions in the PowerShell Notes Application

# Import the functions script to be tested
. ".\Functions.ps1"

# Import required modules
Import-Module -Name Pester

# Describe block for testing Add-Note function
Describe "Add-Note Function Tests" {
    Context "Adding a note with a specified category" {
        It "Should add a note with the specified category to the notes and categories arrays" {
            # Arrange
            $expectedNote = "Test Note"
            $expectedCategory = "Test Category"

            # Act
            Add-Note -Note $expectedNote -Category $expectedCategory

            # Assert
            $addedNote = $Script:Notes[-1]
            $addedCategory = $Script:Categories[-1]
            $addedNote | Should -Be $expectedNote
            $addedCategory | Should -Be $expectedCategory
        }
    }
}

# Describe block for testing Remove-Note function
Describe "Remove-Note Function Tests" {
    Context "Removing a note from the notes array" {
        It "Should remove the note at the specified index from the notes and categories arrays" {
            # Arrange
            $expectedNote = "Test Note"
            $expectedCategory = "Test Category"
            Add-Note -Note $expectedNote -Category $expectedCategory

            # Act
            Remove-Note

            # Assert
            $Script:Notes | Should -NotContain $expectedNote
            $Script:Categories | Should -NotContain $expectedCategory
        }

        It "Should not modify notes or categories arrays when provided with an invalid index" {
            # Arrange
            $initialNotesCount = $Script:Notes.Count
            $initialCategoriesCount = $Script:Categories.Count

            # Act
            Remove-Note

            # Assert
            $Script:Notes.Count | Should -Be $initialNotesCount
            $Script:Categories.Count | Should -Be $initialCategoriesCount
        }
    }
}

# Describe block for testing Edit-Note function
Describe "Edit-Note Function Tests" {
    Context "Editing a note in the notes array" {
        It "Should modify the note content at the specified index" {
            # Arrange
            $expectedNote = "Test Note"
            Add-Note -Note $expectedNote
            $newContent = "Edited Note Content"

            # Act
            Edit-Note 0

            # Assert
            $Script:Notes[0] | Should -Be $newContent
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
            $keyword = "test"

            # Act
            $result = Search-Notes -Keyword $keyword

            # Assert
            $result | Should -Contain "This is a test note"
            $result | Should -Contain "Another test note"
        }

        It "Should notify the user when no notes containing the keyword are found" {
            # Arrange
            $keyword = "nonexistent"

            # Act
            $result = Search-Notes -Keyword $keyword

            # Assert
            $result | Should -Contain "No notes containing the keyword '$keyword' found."
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
            $exportPath = "C:\Temp"

            # Act
            Export-Notes -Path $exportPath

            # Assert
            $exportFilePath = Join-Path -Path $exportPath -ChildPath "Notes.txt"
            Test-Path $exportFilePath | Should -Be $true
            $exportedContent = Get-Content $exportFilePath
            $exportedContent | Should -Contain "Test Note 1"
            $exportedContent | Should -Contain "Test Note 2"
        }
    }
}
