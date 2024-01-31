# This file is the main entry point for the PowerShell Notes Application
# Responsible for handling user interactions and integrating imported functions

# Importing all functions from Functions.ps1
. ".\Functions.ps1"

# Creating a new instance of ArrayList, allowing users to add and remove elements dynamically
$Script:Notes = New-Object System.Collections.ArrayList

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

# Searching notes
Search-Notes "PowerShell"
