function Check-ProcessStatus {
    param($processName)

    $process = Get-Process -Name $processName

    if ($process) {
        write-host "$processName is already running..."
    } else {
        write-host "$processName is not running. Attempting to start ..."
        Start-Process $processName
        Start-Sleep -Seconds 2

        if (Get-Process -Name $processName){
            write-host "$processName started successfuly."
        } else {
            write-host "Failed to start $processName"
        }
    }
}

Check-ProcessStatus "notepad"