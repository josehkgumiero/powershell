# Prompt the user for the application name
$appName = Read-Host "Enter the name of the application"

# Creeate the app data directory name
$appDataDir = "${appName}_Data"

# Create new directory
New-Item $appDataDir -ItemType "Directory"

# Create a new file
New-Item -Path "$appDataDir\config.txt" -ItemType "File"

# Add content to the new file
Add-Content -Path "$appDataDir\config.txt" -Value "Hello, this is a configuration file for the $appName app."

# Verify that the directory was created
Get-ChildItem $appDataDir

# Verify that the content was added
Get-Content -Path "$appDataDir\config.txt"