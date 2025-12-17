#.\function-set-alias-get-help-full.ps1

function GetHelpFull { Get-Help -Full @Args }
Set-Alias explain GetHelpFull
explain Get-Process