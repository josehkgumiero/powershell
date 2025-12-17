$contador = 0

while ($contador -lt 10) {

$testPathFile1 = Test-Path "C:\Users\User\Desktop\powershell\command-out-file-get-process-sort-object-select-oject-report.txt"

echo ""

Write-Host $testPathFile1


if (
    -not $testPathFile1
) {

    echo "Creating itens"

    Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | Out-File "command-out-file-get-process-sort-object-select-oject-report.txt"
    
    Get-ChildItem

    $testPath2File1 = Test-Path "C:\Users\User\Desktop\powershell\command-out-file-get-process-sort-object-select-oject-report.txt"

    if($testPath2File1){
        $contador = 11
    } else {
        $contador = 1
    }
    

} else {

    echo "Removing itens"
    Remove-Item "command-out-file-get-process-sort-object-select-oject-report.txt"

}
}



