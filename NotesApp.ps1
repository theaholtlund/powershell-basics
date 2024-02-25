# This file is the main entry point for the PowerShell Notes Application
# Responsible for handling user interactions and integrating imported functions

# Importing functions and tests from other project scripts
. ".\Categories.ps1"
. ".\NotesFunctions.ps1"

# Creating a new instance of ArrayList for notes
$Script:Notes = New-Object System.Collections.ArrayList

# Creating a new instance of ArrayList for categories, allowing for adding and removing elements dynamically
$Script:Categories = New-Object System.Collections.ArrayList

# Adding example categories
Add-Category "Work"
Add-Category "Personal"

# Adding example notes to the array
Add-Note "This is the first note."
Add-Note "Learning PowerShell basics."
Add-Note "This is a cool and important note."

# Displaying all categories
Show-Categories

# Displaying all notes in the array
Write-Host "`nWelcome to PowerShell Notes Application!" -ForegroundColor Yellow
Show-Notes

# Removing a note from the array based on user input
Remove-Note

# Displaying notes after removing one
Show-Notes

# Asking the user for the index of the note to edit
$IndexToEdit = Read-Host "Enter the index of the note you want to edit"
Edit-Note $IndexToEdit

# Displaying notes after editing
Show-Notes

# Asking the user for the keyword to search
$Keyword = Read-Host @"
Enter keyword to search for.
Please note that the search is case-sensitive and requires exact match.
Type 'exit' to quit.
"@
Search-Notes $Keyword

# Give users the possibility to export notes
$ExportChoice = Read-Host "Do you want to export the notes? (Y/N)"
if ($ExportChoice -eq "Y") {
    $ExportPath = Read-Host "Enter the path for the exported file:"
    Export-Notes -Path $ExportPath
} elseif ($ExportChoice -eq "N") {
    Write-Output "No export of notes at this time."
} else {
    Write-Output "Invalid option. Please choose either 'Y' or 'N'."
}

# Assigning a note to a category
$NoteIndexToAssign = Read-Host "Enter the index of the note you want to assign to a category"
$CategoryIndex = Read-Host "Enter the index of the category you want to assign the note to"
Assign-Category $NoteIndexToAssign $CategoryIndex

# Displaying notes after assigning a category
Show-Notes

# Clear notes, though not strictly needed when app does not loop
Clear-Notes
