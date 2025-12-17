#.\function-start-process-filepath.ps1

Start-Process -FilePath C:\Windows\System32\notepad.exe
Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe"
Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

echo ""

Get-Process

Stop-Process -Name notepad
Stop-Process -Name chrome
Stop-Process -Name msedge

echo ""

Get-Process