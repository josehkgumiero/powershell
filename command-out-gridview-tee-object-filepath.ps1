Get-Process | Tee-Object -FilePath "command-out-gridview-tee-object-filepath-processes.log" | Out-GridView  

Get-Service | Sort-Object Status | Select-Object -First 10 | Tee-Object -FilePath "command-out-gridview-tee-object-filepath-services.txt" | Out-GridView