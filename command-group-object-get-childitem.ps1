Get-ChildItem | Group-Object Extension

Get-Process | Measure-Object WorkingSet -Sum -Average -Maximum -Minimum

Get-Process | Group-Object ProcessName | Measure-Object Count -Average 

Get-ChildItem -File -Recurse | Measure-Object Length -Sum -Average -Maximum -Minimum

Get-ChildItem -File -Recurse | Measure-Object Length -Sum -Average -Maximum -Minimum | Select-Object Count, @{Name="Sum (MB)"; Expression={[math]::Round($_.Sum / 1MB, 2)}}, @{Name="Average (MB)"; Expression={[math]::Round($_.Average / 1MB, 2)}}, @{Name="Maximum (MB)"; Expression={[math]::Round($_.Maximum / 1MB, 2)}}, @{Name="Minimum (MB)"; Expression={[math]::Round($_.Minimum / 1MB, 2)}}

Get-ChildItem -File -Recurse | Group-Object Extension | Select-Object Name, Count | Sort-Object Count -Descending


echo "Test"

Get-ChildItem -File -Recurse | Group-Object Extesion | Select-Object Name, Count, @{Name="TotalSize (MB)"; Expression={($_.Group | Measure-Object Length -Sum).Sum/ 1MB -as [int]}} | Sort-Object "TotalSize (MB)" -Descending