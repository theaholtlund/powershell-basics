# This file contains tests for functions in Functions.ps1
# Responsible for ensuring the functionality of functions in the PowerShell Notes Application

# Import the functions script to be tested
. ".\Functions.ps1"

# Describe block for testing Add-Note function
Describe "Add-Note Function Tests" {
    # Context for testing Add-Note function with programmatically added note
    Context "Adding a note programmatically" {
        It "Should pass when a non-empty note is added programmatically" {
            # Arrange
            $ExpectedNote = "Test Note"  # Provide a mocked input for the note

            # Act
            Add-Note -Note $ExpectedNote

            # Assert
            $AddedNote = $Script:Notes[-1]  # Get the last added note
            $AddedNote | Should -Be $ExpectedNote
        }
    }

    # Context for testing Add-Note function with user input
    Context "Adding a note with user input" {
        It "Should pass when a non-empty note is added via user input" {
            # Arrange
            $mockedInput = "Test Note"  # Provide a mocked input for the note

            # Act
            # Mock the Read-Host call to simulate user input
            Mock Read-Host { $mockedInput } -Verifiable
            Add-Note  # Call Add-Note function, which will prompt the user for input

            # Assert
            $AddedNote = $Script:Notes[-1]  # Get the last added note
            $AddedNote | Should -Be $mockedInput
        }
    }
}
