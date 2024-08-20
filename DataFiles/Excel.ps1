# Working with Excel functionality

# Check if the module is installed and install if not
If (-not (Get-Module -ListAvailable -Name 'ImportExcel')) {
    Install-Module -Name 'ImportExcel' -Scope CurrentUser -Force
}

# Import the module
Import-Module 'ImportExcel'

# Get the directory where the script is located
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the parent directory
$ParentDirectory = Split-Path -Parent $ScriptDirectory

# Define the output folder path
$OutputFolder = Join-Path -Path $ParentDirectory -ChildPath "OutputFiles"

# Define the output file path in the output folder
$OutputFile = Join-Path -Path $OutputFolder -ChildPath "TopMemoryUse.xlsx"

# Get some data about running processes
$MemoryConsumers = Get-Process |
                   Select-Object -Property ProcessName,
                                              @{Name='Memory (MB)';Expression={[math]::Round($_.WS / 1MB, 2)}} |
                   Sort-Object 'Memory (MB)' -Descending |
                   Select-Object -First 5

# Export the data to an Excel file
$MemoryConsumers | Export-Excel -Path $OutputFile -WorksheetName 'TopMemoryConsumers' -TableName 'MemoryConsumers'

# Load the Excel file to add further formatting and a chart
$ExcelPackage = Open-ExcelPackage -Path $OutputFile

# Get the first worksheet
$WorkSheet = $ExcelPackage.Workbook.Worksheets['TopMemoryConsumers']

# Format the memory column for better readability
$WorkSheet.Cells['B2:B6'].Style.Numberformat.Format = '#,##0.00'

# Add a bar chart to visualise memory usage
$ChartName = 'MemoryUsageChart'

# Check if the chart already exists and remove it if it does
$ExistingChart = $WorkSheet.Drawings[$ChartName]
If ($ExistingChart) {
    $WorkSheet.Drawings.Remove($ChartName)
}

# Add the chart to the file
$Chart = $WorkSheet.Drawings.AddChart($ChartName, 'BarClustered')
$Chart.SetPosition(7, 0, 1, 0)
$Chart.SetSize(400, 300)
$Chart.Series.Add("B2:B6", "A2:A6")
$Chart.Title.Text = "Top Memory Consumers"
$Chart.XAxis.Title.Text = "Memory (MB)"
$Chart.YAxis.Title.Text = "Process Name"

# Save the changes to the Excel file
Close-ExcelPackage $ExcelPackage

# Display a message indicating completion
Write-Output "Data has been exported to $OutputFile with formatted numbers and a chart."
