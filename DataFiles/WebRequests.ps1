# Working with web request functionality

# Example postal code for Gardermoen
$PostalCode = '2061' 

# Bring API to validate postal code and get city name
$BringURI = 'https://api.bring.com/shippingguide/api/postalCode.json?clientUrl=dash.training&country=no&pnr='

# Get the postal code details using REST API
$PostalCodeResult = Invoke-RestMethod -Uri ($BringURI + $PostalCode)

# If the result is valid, print out its city
If ($PostalCodeResult.valid) {
    Write-Host -F Yellow "Postal code $PostalCode is valid for $($PostalCodeResult.Result)."
} Else {
    Write-Host -F Darkred "Invalid postal code $PostalCode."
}

# MET.no location forecast API to get weather data
# Add the latitude and longitude for Gardermoen, Norway
$Latitude = '60.1939'
$Longitude = '11.1004'
$MetURI = "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=$Latitude&lon=$Longitude"

# Make the web request to get weather data
$WeatherData = Invoke-RestMethod -Uri $MetURI -Headers @{ "User-Agent" = "PowerShell Script - $env:USERNAME" }

# Select the first forecast entry
$Forecast = $WeatherData.Properties.Timeseries | Select-Object -First 1

# Display the temperature, wind, and pressure
$ForecastData = $Forecast.Data.Instant.Details
$Temperature = "{0} °C" -f $ForecastData.Air_Temperature
$Wind = "{0} {1} mps" -f $ForecastData.Wind_From_Direction, $ForecastData.Wind_Speed
$Pressure = "{0} hPa" -f $ForecastData.Air_Pressure_At_Sea_Level

Write-Host "Temperature: $Temperature"
Write-Host "Wind: $Wind"
Write-Host "Pressure: $Pressure"
