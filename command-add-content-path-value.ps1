
$testPath = Test-Path "C:\Users\User\Desktop\powerhell\command-add-content-path-value-file.txt"

Write-Host $testPath

if ($testPath) {

} else {
    New-Item -Path 'command-add-content-path-value-file.txt' -Value 'This content is a test text'
    Get-Content 'command-add-content-path-value-file.txt'
    echo ""
    Add-Content -Path 'command-add-content-path-value-file.txt' -Value "Journal Entry: $(Get-Date -Format 'yyyy-mm-dd')"
    echo ""
    Get-Content 'command-add-content-path-value-file.txt'
}