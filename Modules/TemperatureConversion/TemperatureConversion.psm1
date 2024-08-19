# Function to convert temperature
Function Convert-Temperature {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [Double]$Celsius
    )

    Process {
        $Fahrenheit = ($Celsius * 9/5) + 32
        Write-Output $Fahrenheit
    }
}
