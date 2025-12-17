$testPathDirectory1 = Test-Path "C:\Users\User\Desktop\powershell\command-remove-item-path" -PathType Container

Write-Host $testPathDirectory1

if (
    -not $testPathDirectory1
) {
    New-Item -Path 'command-remove-item-path' -ItemType Directory

    Get-ChildItem

    $testPath2File2 = Test-Path "C:\Users\User\Desktop\powershell\command-remove-item-path" -PathType Container

    if($testPath2File2){
        
        Remove-Item -Path 'command-remove-item-path'
        
        echo ""

        Get-ChildItem
    }

    

}


