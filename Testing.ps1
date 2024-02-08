# This file contains tests for functions in Functions.ps1
# Responsible for ensuring the functionality of functions in the PowerShell Notes Application

# Import the functions script to be tested
. ".\Functions.ps1"

# Describe block for testing Add-Note function
Describe "Add-Note Function Tests" {
    Context "Adding a note" {
        It "Should add a note to the notes array" {
            # Arrange
            $expectedNote = "Test Note"

            # Act
            Add-Note -Note $expectedNote

            # Assert
            $addedNote = $Script:Notes[-1]
            $addedNote | Should -Be $expectedNote
        }
    }

    Context "Adding a Note without specifying Note parameter" {
        It "Should throw an error" {
            # Arrange & Act & Assert
            { Add-Note } | Should -Throw
        }
    }
}

# Describe block for testing Remove-Note function
Describe "Remove-Note Function Tests" {
    # Add test cases for Remove-Note function
}

# Describe block for testing Edit-Note function
Describe "Edit-Note Function Tests" {
    # Add test cases for Edit-Note function
}

# Describe block for testing Clear-Notes function
Describe "Clear-Notes Function Tests" {
    # Add test cases for Clear-Notes function
}

# Describe block for testing Search-Notes function
Describe "Search-Notes Function Tests" {
    # Add test cases for Search-Notes function
}

# Describe block for testing Export-Notes function
Describe "Export-Notes Function Tests" {
    # Add test cases for Export-Notes function
}
