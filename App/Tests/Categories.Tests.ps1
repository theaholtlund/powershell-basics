# This file contains tests for functions in Categories.ps1

# Import required modules
Import-Module -Name Pester

# Import the code file containing the functions to test
BeforeAll {
    . $PSScriptRoot/../Categories.ps1
}

# Test suite for Set-Categories function
Describe "Set-Categories Function Tests" {
    BeforeEach {
        # Clear $Script:Categories array before each test
        $Script:Categories = $null
    }

    It "Set-Categories should create an empty categories array if it's not already initialised" {
        Set-Categories
        $Script:Categories -notcontains $null
    }

    It "Set-Categories should not modify the categories array if it's already initialised" {
        $Script:Categories = @("Category A", "Category B")
        Set-Categories
        $Script:Categories.Count -eq 2
    }
}

# Test suite for Add-Category function
Describe "Add-Category Function Tests" {
    BeforeEach {
        # Clear $Script:Categories array before each test
        $Script:Categories = @()
    }

    It "Adding a category should add the category to the categories array" {
        Add-Category "TestCategory"
        $Script:Categories[-1] -eq "TestCategory"
    }
}

# Test suite for Remove-Category function
Describe "Remove-Category Function Tests" {
    BeforeEach {
        # Clear $Script:Categories array before each test
        $Script:Categories = @("Category A", "Category B")
    }

    It "Removing an existing category should remove it from the categories array" {
        Remove-Category "Category A"
        $Script:Categories -notcontains "Category A"
    }

    It "Removing a non-existent category should not modify the categories array" {
        $InitialCount = $Script:Categories.Count
        Remove-Category "NonexistentCategory"
        $Script:Categories.Count -eq $InitialCount
    }
}

# Test suite for Rename-Category function
Describe "Rename-Category Function Tests" {
    BeforeEach {
        # Clear $Script:Categories array before each test
        $Script:Categories = @("Category A", "Category B")
    }

    It "Renaming an existing category should update its name in the categories array" {
        Rename-Category "Category A" "NewCategoryA"
        $Script:Categories -contains "NewCategoryA" -and $Script:Categories -notcontains "Category A"
    }

    It "Renaming a non-existent category should not modify the categories array" {
        $InitialCategories = $Script:Categories
        Rename-Category "NonexistentCategory" "NewTestCategory"
        $Script:Categories -eq $InitialCategories
    }
}


# Test suite for Show-Categories function
Describe "Show-Categories Function Tests" {
    BeforeEach {
        # Clear $Script:Categories array before each test
        $Script:Categories = @("Category A", "Category B")
    }

    It "Show-Categories should output a list of categories" {
        $Output = Show-Categories
        $Output[0] -eq "Categories:" | Should -Be $True
        
        # Check each category in the output
        For ($i = 1; $i -lt $Output.Count; $i++) {
            $Output[$i] -match '^\d+ - .+$' | Should -Be $True
        }
    }
}

# Test suite for Set-Category function
Describe "Set-Category Function Tests" {
    BeforeEach {
        # Clear $Script:Notes and $Script:NotesCategories arrays before each test
        $Script:Notes = @("Note 1", "Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Assigning a note to a category should update the note's category in the categories array" {
        Set-Category -NoteIndex 0 -CategoryIndex 1
        $Script:NotesCategories[0] -eq "Category B"
    }

    It "Assigning a note to an invalid category index should not modify the notes categories array" {
        Set-Category -NoteIndex 0 -CategoryIndex 9999
        $Script:NotesCategories[0] -eq "Category A"
    }
}
