# PowerShell Basic Notes Application

## Description

This is a simple PowerShell application to add, remove, display, search, and export notes added by a user. It was created to cover basic functionality and developed as a step in learning introductory PowerShell. There is also a directory called `CmdletPractice`, which only contains simple notes and basic syntax, created for reference and not for functionality.

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
- Pester module installed for testing.

### Executing program and tests

1. Clone the repository.

2. Change into the project directory.

3. Run the categories tests using PowerShell:

   ```sh
   .\App\Tests\Categories.Tests.ps1
   ```

4. Run the other functions tests using PowerShell:

   ```sh
   .\App\Tests\NotesFunctions.Tests.ps1
   ```

5. Run the script using PowerShell:

   ```sh
   .\App\NotesApp.ps1
   ```
