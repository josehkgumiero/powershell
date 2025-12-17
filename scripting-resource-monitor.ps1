$cpu = (Get-CimInstance Win32_Processor).LoadPercentage
$memory = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB

write-host "Current CPU Usage: $cpu %"
write-host "Available Memory: $memory GB"

if (($cpu -gt 90) -and ($memory -lt 2)){
    write-host "Critical: high cpu usage and low memory. Consider closing some application."
} elseif (($cpu -gt 90) -or ($memory -lt 2)){
    write-host "warning: system resouce are strained. Check running processes"
} elseif (($cpu -lt 20) -and ($memory -gt 8)) {
    write-host "system resources are optimal. Good time or system updates."
} else {
    write-host "system resources are normal"
}