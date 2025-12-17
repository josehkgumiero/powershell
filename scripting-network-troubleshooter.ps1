# Display menu options
write-host "Simple Network Troubleshooter"
write-host "1. Test Internet Connection"
write-host "2. View IP Configuration"
write-host "3. Flush DNS"

# Get User input
$choice = Read-Host "Enter your choice [1-3]"

# Use switch statement to handle uer choice
switch($choice){
    "1" {
        # Check Intnernet Connection
        $testResult = Test-Connection -ComputerName www.google.com -Count 1 -Quiet
        if($testResult -eq "True"){
            write-host "Internet connection is working."
        } else {
            write-host "unable to connect to the internet"
        }
    }
    "2" {
        $ipAddress = (Get-NetIpConfiguration).Ipv4Address.IpAddress
        $defaultGateway = (Get-NetIpConfiguration).Ipv4DefaultGateway.NextHop
        write-host "IP Address? $ipAddress"
        write-host "Default Gateway: $defaultGateway"
    }
    "3" {
        #Flush DNS Cache
        Clear-DnsClientCache
        Write-Host "DNS cache has been flushed."

    }
    default {
        # Invalid selection, Try Again
        write-host "Invalid choice. Please run the script again."
    }
}