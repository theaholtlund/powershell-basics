# This file contains tests for functions in Categories.ps1

# Import required modules
Import-Module -Name Pester

# Import the code file containing the functions to test
BeforeAll {
    . $PSScriptRoot/../App/Categories.ps1
}

Describe "Add-Category Function Tests" {
    It "Adding a category should add the category to the categories array" {
        Add-Category "TestCategory"
        $Categories = $Script:NotesCategories
        $Categories[-1] -eq "TestCategory"
    }
}

Describe "Remove-Category Function Tests" {
    It "Removing a category should remove the category from the categories array" {
        Add-Category "TestCategory"
        Remove-Category "TestCategory"
        $Categories = $Script:NotesCategories
        $Categories -notcontains "TestCategory"
    }

    It "Removing a category should not modify the categories array when provided with an invalid category" {
        $InitialCount = $Script:NotesCategories.Count
        Remove-Category "NonexistentCategory"
        $Script:NotesCategories.Count -eq $InitialCount
    }
}

Describe "Rename-Category Function Tests" {
    It "Renaming a category should modify the category name in the categories array" {
        Add-Category "TestCategory"
        Rename-Category "TestCategory" "NewTestCategory"
        $Categories = $Script:NotesCategories
        $Categories -contains "NewTestCategory" -and $Categories -notcontains "TestCategory"
    }

    It "Renaming a category should not modify the categories array when provided with an invalid category" {
        $InitialCategories = $Script:NotesCategories
        Rename-Category "NonexistentCategory" "NewTestCategory"
        $Script:NotesCategories -eq $InitialCategories
    }
}
