$PSVersionTable

$PWD

$HOME

$server = "123.56.78.90"

$myFile = "my_file.txt"

New-Item -Path $myFile -ItemType File

Add-Content -Path $myFile -Value "Powershell, so cool`nVariables make life easy`n Scripting is my jam"

Get-Content -Path $myFile

$timeStamp = Get-Date -Format "yyyyMMdd_HHmmss"

$myFile = "myFile_$timeStamp.txt"

$myFile