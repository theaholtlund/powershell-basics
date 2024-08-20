# Working with Modules

## Overview

This folder contains files used to explore converting functions into modules, using a files for conversion, such as distance and temperature.

## Creating the Module

### 1. Create the Manifest

- `New-ModuleManifest -Path .\Path\To\Modules\Folder -RootModule YourScriptModuleFile.psm1 -Author "Your Name" -Description "Functionality description of your module"`

### 2. Example Import and Test For Module

- `Import-Module .\TemperatureConversion.psm1`
- `Test-ModuleManifest .\TemperatureConversion.psd1`

### 3. Try For Yourself

- `Convert-Temperature -Celsius 100`, should output 212
