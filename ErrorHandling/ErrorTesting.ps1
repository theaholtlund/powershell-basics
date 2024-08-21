# Define a function for error handling demonstration
Function Test-ErrorHandling {
    Param (
        [String]$Name,
        [Int]$Value
    )

    # Error handling with try/catch
    Try {
        # Check if name is empty
        If ([String]::IsNullOrEmpty($Name)) {
            Throw "Name cannot be empty"
        }

        # Check if value is within a valid range
        If ($Value -lt 0 -or $Value -gt 100) {
            Throw "Value must be between 0 and 100"
        }

        # Output message
        Write-Output "Name is '$Name' and value is $Value."

        # Return a success message
        Return "Processing complete for $Name with value $Value."
    } Catch {
        # Handle error
        Write-Error "Error: $_"
    }
}

# Set error action preference to stop on error
$ErrorActionPreference = "Stop"

# Call the function with valid parameters
Test-ErrorHandling -Name "Alice" -Value 50

# Call the function with invalid parameters to test error handling
Test-ErrorHandling -Name "" -Value 50 
Test-ErrorHandling -Name "Bob" -Value 150
