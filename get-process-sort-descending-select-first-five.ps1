#.\get-process-sort-descending-select-first-five.ps1

Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

