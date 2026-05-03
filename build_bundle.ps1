# setup_bundle.ps1
# Script to create a portable Python bundle with pip wrapper

# Prompt user for Python version, default to 3.12.10 if none entered
$pythonVersion = Read-Host "Enter the Python version (default: 3.12.10)"
if ([string]::IsNullOrWhiteSpace($pythonVersion)) {
    $pythonVersion = "3.12.10"
}

# Step 1: Create bundle folder named with version
$suffix = "_bundle"
$bundleName = "python$pythonVersion$suffix"

# Step 2: Create bundle folder
mkdir $bundleName -Force
Set-Location $bundleName

# Step 3: Download Python nuget package
Write-Host "Downloading Python $pythonVersion..."
$nugetUrl = "https://www.nuget.org/api/v2/package/python/$pythonVersion"
curl.exe -L $nugetUrl -o python3.zip

# Step 4: Extract and move Python installation
Expand-Archive .\python3.zip -DestinationPath extracted_nuget
Move-Item .\extracted_nuget\tools python3 -Force
Remove-Item -Recurse -Force extracted_nuget
Remove-Item .\python3.zip

# Step 5: Create Scripts directory
mkdir python3\Scripts -Force

# Step 6: Enable pip
Write-Host "Enabling pip..."
python3\python.exe -m ensurepip
python3\python.exe -m pip update pip

# Step 7: Create pip wrapper script
Write-Host "Creating pip wrapper..."
mkdir pip_wrapper\scripts -Force
@'
#!/usr/bin/python
import sys
import os

if __name__ == "__main__":
    from pip._vendor.distlib.scripts import ScriptMaker
    ScriptMaker.executable = r"python.exe"

    from pip._internal.cli.main import main
    sys.exit(main())
'@ | Out-File -FilePath pip_wrapper\scripts\pip.py -Encoding ascii

# Step 8: Create pip.exe using ScriptMaker with python -c
Write-Host "Generating pip.exe..."
mkdir pip_wrapper\bin -Force
python3\python.exe -c "from pip._vendor.distlib.scripts import ScriptMaker; maker = ScriptMaker('pip_wrapper/scripts','pip_wrapper/bin'); maker.executable = r'python.exe'; maker.make('pip.py')"

# Step 9: Create activation scripts
Write-Host "Creating activation scripts..."

# PowerShell activation script
@"
# activate.ps1
# Activates the Python bundle $pythonVersion

`$env:PATH = "$(Get-Location)\python3;$(Get-Location)\python3\Scripts;$(Get-Location)\pip_wrapper\bin;" + `$env:PATH
Write-Host "Activated Python bundle $pythonVersion"
"@ | Out-File -FilePath activate.ps1 -Encoding ascii

# CMD activation script
@"
:: activate.cmd
:: Activates the Python bundle $pythonVersion

@echo off
set PATH=%~dp0python3;%~dp0python3\Scripts;%~dp0pip_wrapper\bin;%PATH%
echo Activated Python bundle $pythonVersion
"@ | Out-File -FilePath activate.cmd -Encoding ascii

# Step 10: Create batch file to activate and run Hello
Write-Host "Creating run_bundle.bat..."
@"
:: run_bundle.bat
:: Activates the Python bundle and prints Hello

@echo off
call "%~dp0activate.cmd"
python3\python.exe -c "print('Hello, Python Bundle!')"
"@ | Out-File -FilePath run_bundle.bat -Encoding ascii

# Step 11: Optionally install tkinter
$installTkinter = Read-Host "Install tkinter-embed into the bundle? (Y/N, default Y)"
if ([string]::IsNullOrWhiteSpace($installTkinter)) {
    $installTkinter = "Y"
}

if ($installTkinter -match '^[Yy]') {
    Write-Host "Installing tkinter-embed..."
    .\activate.ps1
    pip install --upgrade pip --no-cache-dir
    pip install --target "python3\" tkinter-embed --no-cache-dir
} else {
    Write-Host "Skipping tkinter installation."
}

Write-Host "Bundle setup complete! Created folder: $bundleName"
Write-Host "Use 'activate.ps1' in PowerShell, 'activate.cmd' in cmd.exe, or 'run_bundle.bat' to activate and test."

cd ..