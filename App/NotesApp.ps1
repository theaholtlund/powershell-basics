# This file is the main entry point for the PowerShell Notes Application
# Responsible for handling user interactions and integrating imported functions

# Importing functions from other scripts
. ".\Categories.ps1"
. ".\NotesFunctions.ps1"

# Creating ArrayLists for notes and categories
$Script:Notes = New-Object System.Collections.ArrayList
$Script:Categories = New-Object System.Collections.ArrayList

# Adding example categories
Add-Category "Work"
Add-Category "Personal"

# Adding example notes to the array
Add-Note "This is the first note." "Work"
Add-Note "Learning PowerShell basics." "Personal"
Add-Note "This is a cool and important note." "Work"

# Welcome message
Write-Host "`nWelcome to PowerShell Notes Application!" -ForegroundColor Yellow

# Menu options
Do {
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
    $Choice = Read-Host "Enter your choice (1-9)"

    Switch ($Choice) {
        1 {
            # Display all categories and notes
            Show-Categories
            Show-Notes
        }
        2 {
            # Add a note
            $Note = Read-Host "Enter your note"
            $Category = Read-Host "Enter the category for the note"
            Add-Note $Note $Category
        }
        3 {
            # Edit a note
            $Index = Read-Host "Enter the index of the note you want to edit"
            Edit-Note $Index
        }
        4 {
            # Remove a note
            Remove-Note
        }
        5 {
            # Search notes
            $Keyword = Read-Host @"
Enter keyword to search for.
Please note that the search is case-sensitive and requires exact match.
"@
            Search-Notes $Keyword
        }
        6 {
            # Export notes
            $ExportChoice = Read-Host "Do you want to export the notes? (Y/N)"
            if ($ExportChoice -eq "Y") {
                $ExportPath = Read-Host "Enter the path for the exported file:"
                Export-Notes -Path $ExportPath
            } elseif ($ExportChoice -eq "N") {
                Write-Output "No export of notes at this time."
            } else {
                Write-Output "Invalid option. Please choose either 'Y' or 'N'."
            }
        }
        7 {
            # Assign a category to a note
            $IndexToAssign = Read-Host "Enter the index of the note you want to assign to a category"
            $CategoryIndex = Read-Host "Enter the index of the category you want to assign the note to"
            Set-Category $IndexToAssign $CategoryIndex
        }
        8 {
            # Clear all notes
            Clear-Notes
        }
        9 {
            # Exit
            Write-Host "Bye for now, see you again later!" -ForegroundColor Yellow
            Exit
        }
        Default {
            Write-Host "Invalid choice. Please enter a number from 1 to 9."
        }
    }
} While ($true)
