# Working with Modules

## Overview

This folder contains files used to explore converting functions into modules, using a `Convert-Temperature` function to convert temperatures from Celsius to Fahrenheit.

## Creating the Module

### 1. Create the Manifest

> `New-ModuleManifest -Path .\TemperatureConversion.psd1 -RootModule TemperatureConversion.psm1 -Author "Your Name" -Description "Converts temperatures between Celsius and Fahrenheit"`

### 2. Import and Test Module

> `Import-Module .\TemperatureConversion.psm1` > `Test-ModuleManifest .\TemperatureConversion.psd1`

### 3. Try For Yourself

> `Convert-Temperature -Celsius 100`, should output 212
