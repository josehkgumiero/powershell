
$testPath = Test-Path "C:\Users\User\Desktop\powerhell\command-set-content-path-value-file.txt.txt"

Write-Host $testPath

if ($testPath) {

} else {
    New-Item -Path 'command-set-content-path-value-file.txt' -Value 'This content is a test text'
    Get-Content 'command-set-content-path-value-file.txt'
    echo ""
    Set-Content -Path 'command-set-content-path-value-file.txt' -Value "Journal Entry: $(Get-Date -Format 'yyyy-mm-dd')"
    echo ""
    Get-Content 'command-set-content-path-value-file.txt'
}