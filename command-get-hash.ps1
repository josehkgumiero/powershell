New-Item -Path 'command-get-hash.txt' -ItemType File -Value 'This is our original file'

Get-FileHash 'command-get-hash.txt' -Algorithm MD5