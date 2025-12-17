$contador = 0

while ($contador -lt 10) {

$testPathFile1 = Test-Path "C:\Users\User\Desktop\powershell\command-archive-comprass.txt"
$testPathFile2 = Test-Path "C:\Users\User\Desktop\powershell\command-archive-comprass-directory-1\command-archive-comprass.zip"
$testPathDirectory1 = Test-Path "C:\Users\User\Desktop\powershell\command-archive-comprass-directory-1" -PathType Container

echo ""

Write-Host $testPathFile1
Write-Host $testPathFile2
Write-Host $testPathDirectory1


if (
    -not $testPathFile1 -and
    -not $testPathDirectory1  

) {

    echo "Creating itens"

    New-Item -Path 'command-archive-comprass-directory-1' -ItemType Directory

    1..100000 | ForEach-Object {
        "This is line $_ of a large, compressible file. It contains repititive text to ensure good compression"
    } | Out-File -FilePath "command-archive-comprass.txt"

    $testPath2File1 = Test-Path "C:\Users\User\Desktop\powershell\command-archive-comprass.txt"
    
    if($testPath2File1){
        
        Compress-Archive -Path "command-archive-comprass.txt" -DestinationPath "command-archive-comprass-directory-1\command-archive-comprass.zip"

    }

    Get-ChildItem

    $testPath3File1 = Test-Path "C:\Users\User\Desktop\powershell\command-archive-comprass-directory-1\command-archive-comprass.txt"

    if($testPath3File1){
        $contador = 11
    } else {
        $contador = 1
    }
    

} else {

    if($contador -eq 1){

        Expand-Archive -Path "command-archive-comprass-directory-1\command-archive-comprass.zip"

        $contador = 11

    }

    if($contador -eq 11){

        echo "Removing itens"
        Remove-Item "command-archive-comprass.txt"
        Remove-Item "command-archive-comprass-directory-1"
        Remove-Item "command-archive-comprass"
        
    }
    
    
    

}
}



