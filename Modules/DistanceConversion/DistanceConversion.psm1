# Function to convert distance from miles to kilometers
Function Convert-MilesToKilometers {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [Double]$Miles
    )

    Process {
        $Kilometers = $Miles * 1.60934
        Write-Output $Kilometers
    }
}

# Function to convert distance from kilometers to miles
Function Convert-KilometersToMiles {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [Double]$Kilometers
    )

    Process {
        $Miles = $Kilometers / 1.60934
        Write-Output $Miles
    }
}
