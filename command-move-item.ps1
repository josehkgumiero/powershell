$testPathFile1 = Test-Path "C:\Users\User\Desktop\powershell\command-move-item-directory-1\command-move-item-file-1.txt"
$testPathFile2 = Test-Path "C:\Users\User\Desktop\powershell\command-move-item-directory-2\command-move-item-file-2.txt"
$testPathDirectory1 = Test-Path "C:\Users\User\Desktop\powershell\command-move-item-directory-1" -PathType Container
$testPathDirectory2 = Test-Path "C:\Users\User\Desktop\powershell\command-move-item-directory-2" -PathType Container

Write-Host $testPathFile1
Write-Host $testPathFile2
Write-Host $testPathDirectory1
Write-Host $testPathDirectory2

if (
    -not $testPathDirectory1 -and 
    -not $testPathDirectory2 -and 
    -not $testPathFile1 -and 
    -not $testPathFile2
) {
    New-Item -Path 'command-move-item-directory-1' -ItemType Directory
    New-Item -Path 'command-move-item-directory-1/command-move-item-file-1.txt' -ItemType File -Value 'Content 1'
    New-Item -Path 'command-move-item-directory-2' -ItemType Directory
    New-Item -Path 'command-move-item-directory-2/command-move-item-file-2.txt' -ItemType File -Value 'Content 2'

    Get-ChildItem "C:\Users\User\Desktop\powershell\command-move-item-directory-1"
    Get-ChildItem "C:\Users\User\Desktop\powershell\command-move-item-directory-2"

    $testPath2File2 = Test-Path "C:\Users\User\Desktop\powershell\command-move-item-directory-2\command-move-item-file-2.txt"

    if($testPath2File2){
        
        Move-Item -Path "C:\Users\User\Desktop\powershell\command-move-item-directory-2\command-move-item-file-2.txt" -Destination "C:\Users\User\Desktop\powershell\command-move-item-directory-1"

    }

    Get-ChildItem "C:\Users\User\Desktop\powershell\command-move-item-directory-1"

    $testPath3File2 = Test-Path "C:\Users\User\Desktop\powershell\command-move-item-directory-2\command-move-item-file-2.txt"

    if(-not $testPath3File2){
        Copy-Item -Path "C:\Users\User\Desktop\powershell\command-move-item-directory-1" -Destination "C:\Users\User\Desktop\powershell\command-move-item-directory-2"
    }
}