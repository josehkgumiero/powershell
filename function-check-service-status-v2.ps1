function Check-ServiceStatus {

    param(
        [Parameter(Position=0, Mandatory=$true)]
        [string]$serviceName,
        [Parameter(Position=1)]
        [ValidateSet("Start", "Stop", "None")]
        [string]$action = "None"
    )

    $serviceStatus = (Get-Service -Name $serviceName).Status

    if ($serviceStatus -eq "Stopped") {
        if ($action -eq "Start") {
            write-host "starting $serviceName service ..."
        }
    } else {
        if ($action -eq "Stop") {
            write-host "Stopping $serviceName service ..."
        }
    }
}

Check-ServiceStatus -serviceName "wuauserv" -action "Start"
Check-ServiceStatus -serviceName "windefend" -action "Stop"