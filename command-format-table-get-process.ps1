Get-process

Get-Process | Format-Table Name, ID, CPU

Get-Process | Format-List

Get-ChildItem | Format-Wide

Get-ChildItem | Format-Wide -Column 4

Get-Service | Format-Table Name, Status, StartType

Get-Process chrome | Format-List *

Get-ChildItem | Format-Wide Name -Column 3

Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | Format-Table Name, ID, CPU 

Get-Service | Sort-Object Status | Select-Object -First 10 | Format-List Name, Status, StartType

Get-Service | Sort-Object Status | Select-Object -First 10 | Format-Table Name, Status, StartType