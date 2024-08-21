# Functions for managing note categories in the notes app

# Function to set array if not already initialised
Function Set-Categories {
    If (-not $Script:Categories) {
        $Script:Categories = @()
    }
}

# Function to add a new category to the categories array
Function Add-Category {
    Param (
        [Parameter(Mandatory = $True)]
        [String]$Category
    )
    Set-Categories
    $Script:Categories += $Category
}

# Function to remove a category from the categories array
Function Remove-Category {
    Param (
        [Parameter(Mandatory = $True)]
        [String]$Category
    )
    Set-Categories
    $Script:Categories = $Script:Categories | Where-Object { $_ -ne $Category }
}

# Function to rename a category in the categories array
Function Rename-Category {
    Param (
        [Parameter(Mandatory = $True)]
        [String]$OldCategory,
        [Parameter(Mandatory = $True)]
        [String]$NewCategory
    )
    Set-Categories
    $Index = $Script:Categories.IndexOf($OldCategory)
    If ($Index -ge 0) {
        $Script:Categories[$Index] = $NewCategory
    }
}

# Function to display all categories in the categories array
Function Show-Categories {
    Set-Categories
    Write-Output "Categories:"
    For ($i = 0; $i -lt $Script:Categories.Count; $i++) {
        Write-Output "$i - $($Script:Categories[$i])"
    }
}

# Function to assign a note to a category
Function Set-Category {
    Param (
        [Parameter(Mandatory = $True)]
        [int]$NoteIndex,
        [Parameter(Mandatory = $True)]
        [int]$CategoryIndex
    )

    Set-Categories

    If ($NoteIndex -ge 0 -and $NoteIndex -lt $Script:Notes.Count -and $CategoryIndex -ge 0 -and $CategoryIndex -lt $Script:Categories.Count) {
        $Script:NotesCategories[$NoteIndex] = $Script:Categories[$CategoryIndex]
        Write-Output "Note assigned to category $($Script:Categories[$CategoryIndex])."
    } Else {
        Write-Output "Invalid note or category index."
    }
}
