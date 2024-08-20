# Working with reports and formatting

# Get the directory where the script is located
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the parent directory (one level up from the script's directory)
$ParentDirectory = Split-Path -Parent $ScriptDirectory

# Define the output folder path
$OutputFolder = Join-Path -Path $ParentDirectory -ChildPath "OutputFiles"

# Define the output file path in the output folder
$OutputFile = Join-Path -Path $OutputFolder -ChildPath "SystemReport.html"

# Get macOS version
$OSVersion = sw_vers -productVersion

# Get the hostname
$HostName = hostname

# Create HTML report
$HTMLContent = @"
<html>
<head>
    <title>System Information Report</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f4f4f4; }
        h1 { text-align: center; }
    </style>
</head>
<body>
    <h1>System Information Report</h1>
    <table>
        <tr>
            <th>Property</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>macOS Version</td>
            <td>$OSVersion</td>
        </tr>
        <tr>
            <td>Hostname</td>
            <td>$HostName</td>
        </tr>
    </table>
</body>
</html>
"@

# Save the HTML content to a file
$HTMLContent | Out-File -FilePath $OutputFile -Encoding utf8

Write-Output "Report saved to $OutputFile"
