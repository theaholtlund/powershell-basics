# This file contains tests for functions in Functions.ps1
# Responsible for ensuring the functionality of functions in the PowerShell Notes Application

# Import the functions script to be tested
. ".\Functions.ps1"

# Import required modules
Import-Module -Name Pester

# Describe block for testing Add-Note function
Describe "Add-Note Function Tests" {
    # Context for testing Add-Note function with programmatically added note
    Context "Adding a note programmatically" {
        It "Should add a note to the notes array when a non-empty note is provided" {
            # Arrange
            $expectedNote = "Test Note"

            # Act
            Add-Note -Note $expectedNote

            # Assert
            $addedNote = $Script:Notes[-1]
            $addedNote | Should -Be $expectedNote
        }
    }

    # Context for testing Add-Note function with user input
    Context "Adding a note with user input" {
        It "Should add a non-empty note to the notes array when user provides input" {
            # Arrange
            $mockedInput = "User Input Note"

            # Act
            Mock Read-Host { $mockedInput } -Verifiable
            Add-Note

            # Assert
            $addedNote = $Script:Notes[-1]
            $addedNote | Should -Be $mockedInput
        }
    }
}

# Describe block for testing Remove-Note function
Describe "Remove-Note Function Tests" {
    # Context for testing Remove-Note function
    Context "Removing a note from the notes array" {
        It "Should remove the note at the specified index from the notes array" {
            # Arrange
            $expectedNote = "Test Note"
            Add-Note -Note $expectedNote

            # Act
            Remove-Note

            # Assert
            $Script:Notes | Should -NotContain $expectedNote
        }
    }
}

# Describe block for testing Edit-Note function
Describe "Edit-Note Function Tests" {
    # Context for testing Edit-Note function
    Context "Editing a note in the notes array" {
        It "Should modify the note at the specified index with the new content" {
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
    # Context for testing Clear-Notes function
    Context "Clearing all notes from the notes array" {
        It "Should remove all notes from the notes array" {
            # Arrange
            Add-Note -Note "Test Note 1"
            Add-Note -Note "Test Note 2"

            # Act
            Clear-Notes

            # Assert
            $Script:Notes | Should -BeNullOrEmpty
        }
    }
}

# Describe block for testing Search-Notes function
Describe "Search-Notes Function Tests" {
    # Context for testing Search-Notes function
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
    }
}

# Describe block for testing Export-Notes function
Describe "Export-Notes Function Tests" {
    # Context for testing Export-Notes function
    Context "Exporting notes to a text file" {
        It "Should create a text file containing all notes" {
            # Arrange
            Add-Note -Note "Test Note 1"
            Add-Note -Note "Test Note 2"
            $exportPath = "C:\Temp"

            # Act
            Export-Notes -Path $exportPath

            # Assert
            $exportFilePath = Join-Path -Path $exportPath -ChildPath "Notes.txt"
            Test-Path $exportFilePath | Should -Be $true
        }
    }
}
