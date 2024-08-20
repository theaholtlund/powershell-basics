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
                   Select-Object -Property ProcessName,
                                              @{Name='Memory (MB)';Expression={[math]::Round($_.WS / 1MB, 2)}} |
                   Sort-Object 'Memory (MB)' -Descending |
                   Select-Object -First 5

# Export the data to an Excel file
$MemoryConsumers | Export-Excel -Path $ExcelFilePath -WorksheetName 'TopMemoryConsumers' -AutoSize -TableName 'MemoryConsumers'

# Load the Excel file to add further formatting and a chart
$ExcelPackage = Open-ExcelPackage -Path $ExcelFilePath

# Get the first worksheet
$WorkSheet = $ExcelPackage.Workbook.Worksheets['TopMemoryConsumers']

# Format the Memory (MB) column for better readability
$WorkSheet.Cells['B2:B6'].Style.Numberformat.Format = '#,##0.00'

# Add a bar chart to visualize memory usage
$Chart = $WorkSheet.Drawings.AddChart('MemoryUsageChart', 'BarClustered')
$Chart.SetPosition(7, 0, 1, 0)
$Chart.SetSize(400, 300)
$Chart.Series.Add("B2:B6", "A2:A6")
$Chart.Title.Text = "Top Memory Consumers"
$Chart.XAxis.Title.Text = "Memory (MB)"
$Chart.YAxis.Title.Text = "Process Name"

# Save the changes to the Excel file
Close-ExcelPackage $ExcelPackage

# Display a message indicating completion
Write-Output "Data has been exported to $ExcelFilePath with formatted numbers and a chart."
