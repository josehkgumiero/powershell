$computerName = $env:COMPUTERNAME
$osInfo = Get-CimInstance Win32_OperatingSystem
$cpu = (Get-CimInstance Win32_Processor).LoadPercentage
$totalMemory = $osInfo.TotalVisibleMemorySize / 1MB
$freeMemory = $osInfo.FreePhysicalMemory / 1MB
$totalSpace = (Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object DeviceID -eq 'C:').Size / 1GB
$freeSpace = (Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object DeviceID -eq 'C:').FreeSpace / 1GB

$upTime = (Get-Date) - $osInfo.LastBootUpTime
$upTimeDays = $upTime.Days
$upTimeHours = $upTime.Hours
$upTimeMinutes = $upTime.Minutes

$report = "System Health Report`n"
$report += "---------------------`n"
$report += "Generated on: {0:yyyy-MM-dd HH:mm:ss}`n`n" -f (Get-Date)

$report += "Computer name: {0}`n" -f $computerName
$report += "OS name: {0}`n" -f $osInfo.Caption
$report += "OS version {0}`n" -f $osInfo.Version
$report += "CPU Usage: {0}%`n" -f $cpu
$report += "Memory: {0:N2} GB free of {1:N2} GB`n" -f $freeMemory, $totalMemory
$report += "Disk (C:) {0:N2} GB of {1:N2} GB`n" -f $freeSpace, $totalSpace

$report += "System Uptime: {0}`n`n" -f $(
    $upTimeString = ""

    if ($upTimeDays -gt 0) {
        $upTimeString += "$upTimeDays days, "
    }

    if ($upTimeHours -gt 0 -or $upTimeDays -gt 0) {
        $upTimeString += "$upTimeHours hours,"
    }

    $upTimeString += "$upTimeMinutes minutes"

    $upTimeString
)


$memoryUsagePercent = 100 - (($freeMemory/$totalMemory)*100)
$diskUsagePercent = 100 - (($freeSpace/$totalSpace)*100)
$report += "`nUsage percentage`n"
$report += "Memory: {0:N2}% used`n" -f $memoryUsagePercent
$report += "Disk (C:): {0:N2}% used`n" -f $diskUsagePercent


write-host $report