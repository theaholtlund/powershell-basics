# This file contains functions for managing note categories in the PowerShell Notes Application

# Function to add a new category
Function Add-Category {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Category
    )
    $Script:Categories.Add($Category) | Out-Null
}

# Function to display all categories
Function Show-Categories {
    Write-Output "Categories:"
    For ($i = 0; $i -lt $Script:Categories.Count; $i++) {
        Write-Output "$i - $($Script:Categories[$i])"
    }
}

# Function to assign a note to a category
Function Assign-Category {
    param (
        [Parameter(Mandatory = $true)]
        [int]$NoteIndex,
        [Parameter(Mandatory = $true)]
        [int]$CategoryIndex
    )

    if ($NoteIndex -ge 0 -and $NoteIndex -lt $Script:Notes.Count -and $CategoryIndex -ge 0 -and $CategoryIndex -lt $Script:Categories.Count) {
        $Script:NotesCategories[$NoteIndex] = $Script:Categories[$CategoryIndex]
        Write-Output "Note assigned to category $($Script:Categories[$CategoryIndex])."
    } else {
        Write-Output "Invalid note or category index."
    }
}
