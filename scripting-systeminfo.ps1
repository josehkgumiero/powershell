# Display menu options for system information

write-host "What system information would you like to see?`n1. Operating System`n2. CPU`n3. Total memory`n4. CurretUser"

# Get user input
$choice = Read-Host "Enter your choice (1-4)"

# switch statement to handle user choice
switch($choice){
    "1"{
        # Operating System info here
        $os = Get-CimInstance Win32_OperatingSystem
        $osName = $os.Caption
        $osVersion= $os.Version
        write-host "Operaating System $osName"
        write-host "Version: $osVersion"
    }
    "2"{
        # CPU info here
        $cpu = Get-CimInstance Win32_Processor
        $cpuName = $cpu.name
        $cpuCores = $cpu.NumberOfCores
        $cpuSpeed = $cpu.MaxClockSpeed
        write-host "CPU Name: $cpuName"
        write-host "Number of Cores: $cpuCores"
        write-host "Max Clock Speed: $($cpuSpeed/100) GHz"
    }
    "3"{
        # Memory info here
        $totalMemoryGB = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
        write-host "Total Physical Memory: $totalMemoryGB GB"
    }
    "4"{
        # currente user info here
        $currentUser = $env:USERNAME
        write-host "Current User: $currentUser"
    }
    default {
        write-host "Invalid choice. Please run the script again"
    }
}