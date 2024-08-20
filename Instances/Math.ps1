# Working with mathematical processes

# Retrieve value of PI from the System.Math class
$PIValue = [System.Math]::PI

# Round value of PI to three decimals
$RoundedPI = [System.Math]::Round($PIValue, 3)

# Output rounded value
Write-Output "The rounded value of PI is $RoundedPI"
