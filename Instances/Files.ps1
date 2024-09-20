# Working with file processing

# Get the directory where the script is located
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the parent directory
$ParentDirectory = Split-Path -Parent $ScriptDirectory

# Define the output folder path
$OutputFolder = Join-Path -Path $ParentDirectory -ChildPath "OutputFiles"

# Define the output file path in the output folder
$OutputFile = Join-Path -Path $OutputFolder -ChildPath "Download.jpg"

# Create a new WebClient instance
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile('https://www.graydaycafe.com/images/bg.jpg', $OutputFile)

# The above code as one line
(New-Object System.Net.WebClient).DownloadFile('https://www.graydaycafe.com/images/bg.jpg', $OutputFile)

# Check if the file exists
If (Test-Path $OutputFile) {
    Write-Host "The file has been downloaded successfully."

    # Get the file size
    $FileSize = (Get-Item $OutputFile).Length
    Write-Host "The file size is $($FileSize / 1KB) KB." 

} Else {
    Write-Host "Download failed or file does not exist."
}
