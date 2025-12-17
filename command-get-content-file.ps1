
$testPath = Test-Path "C:\Users\User\Desktop\powerhell\'command-get-content-file.txt'.txt"

Write-Host $testPath

if ($testPath) {

} else {
    New-Item -Path 'command-get-content-file.txt' -Value 'This content is a test text'
    Get-Content 'command-get-content-file.txt'
    echo ""
    Get-Content 'command-get-content-file.txt' -TotalCount 3
    echo ""
    Get-Content 'command-get-content-file.txt' -Tail 5
}