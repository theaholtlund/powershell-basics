# This file is the main entry point for the PowerShell Notes Application
# Responsible for handling user interactions and integrating imported functions

# Importing functions and tests from other scripts
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

# Welcome message
Write-Host "`nWelcome to PowerShell Notes Application!" -ForegroundColor Yellow

# Menu options
do {
    Write-Host "`nChoose an option:"
    Write-Host "1. View Notes"
    Write-Host "2. Add a Note"
    Write-Host "3. Edit a Note"
    Write-Host "4. Remove a Note"
    Write-Host "5. Search Notes"
    Write-Host "6. Export Notes"
    Write-Host "7. Assign Category to Note"
    Write-Host "8. Clear All Notes"
    Write-Host "9. Exit"
    $choice = Read-Host "Enter your choice (1-9)"

    switch ($choice) {
        1 {
            # Display all categories
            Show-Categories
            # Display all notes
            Show-Notes
        }
        2 {
            # Add a note
            $note = Read-Host "Enter your note"
            Add-Note $note
        }
        3 {
            # Edit a note
            $index = Read-Host "Enter the index of the note you want to edit"
            Edit-Note $index
        }
        4 {
            # Remove a note
            Remove-Note
        }
        5 {
            # Search notes
            $keyword = Read-Host @"
Enter keyword to search for.
Please note that the search is case-sensitive and requires exact match.
Type 'exit' to quit.
"@
            Search-Notes $keyword
        }
        6 {
            # Export notes
            $exportChoice = Read-Host "Do you want to export the notes? (Y/N)"
            if ($exportChoice -eq "Y") {
                $exportPath = Read-Host "Enter the path for the exported file:"
                Export-Notes -Path $exportPath
            } elseif ($exportChoice -eq "N") {
                Write-Output "No export of notes at this time."
            } else {
                Write-Output "Invalid option. Please choose either 'Y' or 'N'."
            }
        }
        7 {
            # Assign a category to a note
            $indexToAssign = Read-Host "Enter the index of the note you want to assign to a category"
            $categoryIndex = Read-Host "Enter the index of the category you want to assign the note to"
            Assign-Category $indexToAssign $categoryIndex
        }
        8 {
            # Clear all notes
            Clear-Notes
        }
        9 {
            # Exit
            Write-Host "Bye for now, see you again later!" -ForegroundColor Yellow
            exit
        }
        default {
            Write-Host "Invalid choice. Please enter a number from 1 to 9."
        }
    }
} while ($true)
