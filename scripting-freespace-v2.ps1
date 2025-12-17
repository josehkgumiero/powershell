# Get the total spaceon the C Drive (in GB), rounded to 2 decimal places
$totalSpace = [Math]::Round((Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'").Size/1GB, 2)

$totalSpace

# Get free space on C drive in GB, rounded to a 2 decimal palces
$freeSpace = [Math]::Round((Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object DeviceID -eq 'C:').FreeSpace/1GB, 2)


$freeSpace


# Calculate the percentage of free space
$freePercentage = ($freeSpace / $totalSpace) * 100

if ($freePercentage -gt 25) {
    write-host "plenty of space available! ($freePercentage% free)"
} else {
    write-host "critical: almost full! Time to delete some file! ($freePercentage% free)"
}