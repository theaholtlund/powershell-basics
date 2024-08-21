# Define a simple function that can be used for debug testing
Function Test-Debugging {
    Param (
        [String]$Name,
        [Int]$Age
    )

    # Example of Write-Verbose, required -verbose flag
    Write-Verbose "Entering debug testing with name: $Name and age: $Age"

    # Check age and write debug message
    If ($Age -lt 18) {
        Write-Debug "Age is less than 18"
        Write-Output "You are a minor."
    } Else {
        Write-Debug "Age is 18 or older"
        Write-Output "You are an adult."
    }

    # Introduce variable for debugging
    $Greeting = "Hello, $Name! You are $Age years old."

    # Write-Debug example With variable
    Write-Debug "Greeting message: $Greeting"

    # Return Greeting Message
    Return $Greeting
}

# Enable debugging output
$DebugPreference = "Continue"

# Call the function with parameters and verbose
Test-Debugging -Name "Alice" -Age 17 -Verbose

# Set PSDebug to step-through mode
Set-PSDebug -Step

# Call the function again to step through it
Test-Debugging -Name "Bob" -Age 25

# Disable PSDebug
Set-PSDebug -Off
