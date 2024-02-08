# PowerShell Basic Notes Application

## Description

This is a simple PowerShell application to add, remove, display, search, and export notes added by a user. It was created to cover basic functionality and developed as a step in learning introductory PowerShell. There is also a directory called `CmdletPractice`, which only contains simple notes and basic syntax, created for reference and not for functionality.

## Main Features

- **Add Notes**: Easily add new notes to the collection.
- **Display Notes**: View all notes in one place.
- **Remove Notes**: Remove specific notes by index.
- **Clear Notes**: Clear all notes from the collection at once.
- **Search Notes**: Search for specific keywords within all the notes.
- **Export Notes**: Export notes to a text file.

## Getting Started

### Prerequisites

- PowerShell installed on the system.
- Pester module installed for testing.

### Executing program

1. Clone the repository.

2. Change into the project directory.

3. Import the Pester module using PowerShell:

   ```sh
   Import-Module -Name Pester
   ```

4. Run the script using PowerShell:

   ```sh
   .\NotesApp.ps1
   ```
