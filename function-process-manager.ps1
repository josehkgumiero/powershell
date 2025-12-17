param(
    [Parameter(Mandatory=$true)]
    [string]$processName,
    [Parameter(Mandatory=$true)]
    [ValidateSet("Start", "Stop", "Restart", "Info")]
    [string]$action
)

switch ($action) {
    "Start" {
        if (Get-Process -Name $processName) {
            write-host "process $processName is already running"
        } else {
            Start-Process $processName
            write-host "Started process $processName"
        }
    }
    "Stop" {
        if (Get-Process -Name $processName) {
            Stop-Process -Name $processName -Force
            write-host "Stopped process $processName"
        } else {
            write-host "Process $processName is not running"
        }

    }
    "Restart" {
        if (Get-Process -Name $processName) {
            Stop-Process -Name $processName -Force
            Start-Process $processName
            write-host "Restarted process $processName"
        } else {
            Start-Process $processName
            write-host "process $processName was not runnning. Started it."
        }
    }
    "Info" {
        $pocess = Get-Processs $processName
        if ($process) {
            write-host "Process name: $($process.Name)"
            write-host "Process ID: $($process.Id)"
            write-host "CPU usage: $($process.CPU)"
            write-host "Memory usage: $($process.WorkingSet64 /1MB) MB"
        } else {
            write-host "Process $processName is not running"
        }
    }
}