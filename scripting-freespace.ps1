# Get the free space in GB on the device
$freeSpace = (Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object DeviceID -eq 'C:').FreeSpace / 1GB

# Check free space and provide message
if ($freeSpace -gt 50){
    write-host "Plenty of space available"
} elseif($freeSpace -gt 20){
    write-host "you are doing okay, but might want to think about clearing some space soon"
} elseif($freeSpace -gt 5){
    write-host "Warning: You are running low on space"
} else {
    write-host "critical: almost full! Time to delete some files."
}

write-host "you have $freeSpace"