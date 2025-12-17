write-host "welcome to the process checker!"

$runningCount = 0
$notRunningCount = 0

function Check-ProcessStatus {
    param(
        [Parameter(Mandatory=$true)]
        [string]$processName
    )

    $process = Get-Process -Name $processName

    if ($process) {
        $script:runningCount++
        return $true
    } else {
        $script:notRunningCount++
        return $false
    }
}

if (Check-ProcessStatus "explorer"){
    write-host "windows explorer is running"
} else {
    write-host "windows explorer is not running. This is unsual and may indicate a problem"
}

if (Check-ProcessStatus "Taskmgr") {
    write-host "task manager is running"
} else {
    write-host "task manager is not running. This is normal if it has not been started."
}

if (Check-ProcessStatus "SecurityHealthSystray") {
    write-host "windows security is running."
} else {
    write-host "windows security is not running."
}

write-host "`nProcess Check Sumary`n"
write-host "Total processes checked: $($runningCount + $notRunningCount)"
write-host "Processes found running: $runningCount"
write-host "Processes not running: $notRunningCount"