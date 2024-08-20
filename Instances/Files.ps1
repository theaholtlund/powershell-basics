# Working with file processing

# Define output path in the same directory as the script
$OutputPath = Join-Path -Path $PSScriptRoot -ChildPath 'download.jpg'

# Create a new WebClient instance
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile('https://www.graydaycafe.com/images/bg.jpg', $OutputPath)

# The above code as one line
(New-Object System.Net.WebClient).DownloadFile('https://www.graydaycafe.com/images/bg.jpg', $OutputPath)
