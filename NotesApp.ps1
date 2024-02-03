# This file is the main entry point for the PowerShell Notes Application
# Responsible for handling user interactions and integrating imported functions

# Importing all functions from Functions.ps1
. ".\Functions.ps1"

# Creating a new instance of ArrayList, allowing users to add and remove elements dynamically
$Script:Notes = New-Object System.Collections.ArrayList

# Main loop to keep the program running until the user decides to exit
while ($true) {
    # Adding example notes to the array
    Add-Note "This is the first note."
    Add-Note "Learning PowerShell basics."
    Add-Note "This is a cool and important note."

    # Displaying all notes in the array
    Show-Notes

    # Removing a note from the array based on user input
    Remove-Note

    # Displaying notes after removing one
    Show-Notes

    # Clearing all notes
    Clear-Notes
    Show-Notes

    # Asking the user for the keyword to search
    $Keyword = Read-Host "Enter the keyword to search for. Type 'exit' to quit."
    if ($Keyword -eq "exit") {
        break
    }

    # Searching notes for the provided keyword
    Search-Notes $Keyword

    # Give users the possibility to export notes
    $ExportChoice = Read-Host "Do you want to export the notes? (Y/N)"
    if ($ExportChoice -eq "Y") {
        $ExportPath = Read-Host "Enter the path for the exported file, such as C:\Notes\exported_notes.txt)"
        Export-Notes -Path $ExportPath
    }
}
