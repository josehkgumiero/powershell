(Get-ChildItem Random_File.txt).LastWriteTime = [datetime]::ParseExact("01/01/2025", "mm/dd/yyyy", $null)
(Get-ChildItem Random_File.txt).LastWriteTime