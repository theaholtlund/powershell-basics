# Working with Excel functionality

# Define the ImportExcel module name
$ImportExcelModuleName = 'ImportExcel'

# Check if the module is installed and install if not
If (-not (Get-Module -ListAvailable -Name $ImportExcelModuleName)) {
    Install-Module -Name $ImportExcelModuleName -Scope CurrentUser -Force
}

# Import the module
Import-Module $ImportExcelModuleName

# Get the directory where the script is located
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the output Excel file path in the same directory as the script
$ExcelFilePath = Join-Path -Path $ScriptDirectory -ChildPath "TopMemoryUse.xlsx"

# Get some data about running processes
$MemoryConsumers = Get-Process |
                   Select-Object -Property ProcessName, WS |
                   Sort-Object WS -Descending |
                   Select-Object -First 5

# Export the data to an Excel file
$MemoryConsumers | Export-Excel -Path $ExcelFilePath -WorksheetName 'TopMemoryUse' -AutoSize -TableName 'MemoryConsumers'

# Display a message indicating completion
Write-Output "Data has been exported to $ExcelFilePath"
