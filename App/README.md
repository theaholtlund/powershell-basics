# PowerShell Basic Notes Application

## Description

A simple PowerShell application to add, remove, display, search and export notes added by a user. Covers basic functionality, developed as a step in learning introductory PowerShell.

## Main Features

- **Add Notes**: Easily add new notes along with their categories.
- **Display Notes**: View all notes with their respective categories.
- **Edit Notes**: Modify the content of existing notes.
- **Remove Notes**: Delete specific notes from the collection.
- **Search Notes**: Find notes containing specific keywords.
- **Assign Categories**: Associate categories with individual notes.
- **Export Notes**: Save notes to a text file for external use.

## Getting Started

### Prerequisites

- PowerShell installed on the system.
- Pester module installed for unit testing.

### Executing program and tests

1. Run the categories tests using PowerShell:

   ```sh
   .\App\Tests\Categories.Tests.ps1
   ```

2. Run the other functions tests using PowerShell:

   ```sh
   .\App\Tests\NotesFunctions.Tests.ps1
   ```

3. Run the script using PowerShell:

   ```sh
   .\App\NotesApp.ps1
   ```
