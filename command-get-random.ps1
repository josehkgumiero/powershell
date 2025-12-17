#.\function-get-random.ps1

echo ""

Get-Random

echo ""

Get-Random -Maximum 100

echo ""

Get-Random -Minimum -100 -Maximum 100

echo ""

Get-Random -Minimum 10.7 -Maximum 20.93

echo ""

1, 2, 3, 5, 8, 13 | Get-Random

echo ""

1, 2, 3, 5, 8, 13 | Get-Random -Count 3

echo ""

1, 2, 3, 5, 8, 13 | Get-Random -Count ([int]::MaxValue)

echo ""

"red", "yellow", "blue" | Get-Random

echo ""

Get-Random -Maximum 100 -SetSeed 23
Get-Random -Maximum 100
Get-Random -Maximum 100
Get-Random -Maximum 100

echo ""

$Files = Get-ChildItem -Path C:\* -Recurse
$Sample = $Files | Get-Random -Count 50

echo ""

1..1200 | ForEach-Object {
    1..6 | Get-Random
} | Group-Object | Select-Object Name,Count