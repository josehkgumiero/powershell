# sk to user the process name
$processName = Read-Host "Enter the name of your application"


# Try to get the process
$processObject = Get-Process $processName

# Check if the process is running and responding
# -not $processObject
# !processObject
if($processObject -eq $null){
    write-host "$processName is not currently running."
} elseif($processObject.responding) {
    write-host "$processName is working correctly"
} else {
    write-host "$processName is unresponsive, closing..."
    $processObject.Kill()
}
