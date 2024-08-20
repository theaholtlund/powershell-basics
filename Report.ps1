# Define the output file path
$OutputFile = "SystemReport.html"

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
