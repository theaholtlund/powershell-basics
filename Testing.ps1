# This file contains tests for functions in Functions.ps1
# Responsible for ensuring the functionality of functions in the PowerShell Notes Application

# Import the functions script to be tested
. ".\Functions.ps1"

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
