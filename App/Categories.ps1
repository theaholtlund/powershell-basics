# This file contains functions for managing note categories in the PowerShell Notes Application

# Function to initialise the $Script:Categories array if not already initialised
Function Initialize-Categories {
    If (-not $Script:Categories) {
        $Script:Categories = New-Object System.Collections.ArrayList
    }
}

# Function to add a new category to the categories array
Function Add-Category {
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Category
    )
    Initialize-Categories
    $Script:Categories.Add($Category) | Out-Null
}

# Function to remove a category from the categories array
Function Remove-Category {
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Category
    )
    Initialize-Categories
    $Script:Categories.Remove($Category) | Out-Null
}

# Function to rename a category in the categories array
Function Rename-Category {
    Param (
        [Parameter(Mandatory = $true)]
        [String]$OldCategory,
        [Parameter(Mandatory = $true)]
        [String]$NewCategory
    )
    Initialize-Categories
    $Index = $Script:Categories.IndexOf($OldCategory)
    If ($Index -ge 0) {
        $Script:Categories[$Index] = $NewCategory
    }
}

# Function to display all categories in the categories array
Function Show-Categories {
    Initialize-Categories
    Write-Output "Categories:"
    For ($i = 0; $i -lt $Script:Categories.Count; $i++) {
        Write-Output "$i - $($Script:Categories[$i])"
    }
}

# Function to assign a note to a category
Function Set-Category {
    Param (
        [Parameter(Mandatory = $true)]
        [int]$NoteIndex,
        [Parameter(Mandatory = $true)]
        [int]$CategoryIndex
    )

    Initialize-Categories

    If ($NoteIndex -ge 0 -and $NoteIndex -lt $Script:Notes.Count -and $CategoryIndex -ge 0 -and $CategoryIndex -lt $Script:Categories.Count) {
        $Script:NotesCategories[$NoteIndex] = $Script:Categories[$CategoryIndex]
        Write-Output "Note assigned to category $($Script:Categories[$CategoryIndex])."
    } Else {
        Write-Output "Invalid note or category index."
    }
}
