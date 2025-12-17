# Conversion Operator Example
$userInput = Read-Host "Enter a number"

if ($userInput -as [int]) {
    write-host "Good job! You entered valid number."
} else {
    write-host "Try again! You did not enter a number"
}

if ($userInput -match '^\d+$') {
    write-host "Good job! You entered valid number: $userInput"
} else {
    write-host "Try again! You did not enter a number"
}

if ($userInput -is [int]) {
    write-host "Good job! You entered an integer"
} else {
    write-host "Try again! You did not etnter an integer"
}

$fileName = Read-Host "Enterthe name of file in this format: report_YYYY_MM_DD.xlsx"

if ($fileName -like "report_*.xlsx") {
    Write-Host "Valid report filename"
} else {
    Write-Host "Invalid report filename. It should be in format 'report_YYYY_MM_DD.xlsx"
}

$documentName = read-host "enter te name of document"

if ($documentName -notlike "*.txt") {
    write-host "the document is not a text file"
} else {
    write-host "the document is a text file"
}