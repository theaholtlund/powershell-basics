# This file contains functions for managing note categories in the PowerShell Notes Application

# Function to initialize the $Script:Categories array
Function Initialize-Categories {
    if (-not $Script:Categories) {
        $Script:Categories = New-Object System.Collections.ArrayList
    }
}

# Function to add a new category
Function Add-Category {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Category
    )
    Initialize-Categories
    $Script:Categories.Add($Category) | Out-Null
}

# Function to remove a category
Function Remove-Category {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Category
    )
    Initialize-Categories
    $Script:Categories.Remove($Category) | Out-Null
}

# Function to rename a category
Function Rename-Category {
    param (
        [Parameter(Mandatory = $true)]
        [String]$OldCategory,
        [Parameter(Mandatory = $true)]
        [String]$NewCategory
    )
    Initialize-Categories
    $Index = $Script:Categories.IndexOf($OldCategory)
    if ($Index -ge 0) {
        $Script:Categories[$Index] = $NewCategory
    }
}

# Function to display all categories
Function Show-Categories {
    Initialize-Categories
    Write-Output "Categories:"
    For ($i = 0; $i -lt $Script:Categories.Count; $i++) {
        Write-Output "$i - $($Script:Categories[$i])"
    }
}

# Function to assign a note to a category
Function Set-Category {
    param (
        [Parameter(Mandatory = $true)]
        [int]$NoteIndex,
        [Parameter(Mandatory = $true)]
        [int]$CategoryIndex
    )

    Initialize-Categories

    if ($NoteIndex -ge 0 -and $NoteIndex -lt $Script:Notes.Count -and $CategoryIndex -ge 0 -and $CategoryIndex -lt $Script:Categories.Count) {
        $Script:NotesCategories[$NoteIndex] = $Script:Categories[$CategoryIndex]
        Write-Output "Note assigned to category $($Script:Categories[$CategoryIndex])."
    } else {
        Write-Output "Invalid note or category index."
    }
}
