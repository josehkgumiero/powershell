$testPathDirectory1 = Test-Path "C:\Users\User\Desktop\powershell\command-rename-item-path-newname" -PathType Container

Write-Host $testPathDirectory1

if (
    -not $testPathDirectory1
) {
    New-Item -Path 'command-rename-item-path-newname' -ItemType Directory

    Get-ChildItem

    $testPath2File2 = Test-Path "C:\Users\User\Desktop\powershell\command-rename-item-path-newname" -PathType Container

    if($testPath2File2){
        
        Rename-Item -Path 'command-rename-item-path-newname' -NewName 'command-rename-item-path-renamed'
        
        echo ""

        Get-ChildItem
    }

    

}


