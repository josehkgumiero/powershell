function Check-ServiceStatus {
    param($serviceName)
    $serviceStatus = (Get-Service -Name $serviceName).Status
    if ($serviceStatus -eq "Stopped") {
        #write-host "$serviceName srvice is stopped.Atempting to start..."
        return $false
    } else {
        #write-host "$serviceName service is running. No action to needed."
        return $true
    }
}

Check-ServiceStatus "wuauserv"
Check-ServiceStatus "windefend"

if (Check-ServiceStatus "wuauserv") {
    write-host "Windows Update service is running"
}