#.\function-get-sha1.ps1

function Get-SHA1 {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Text
    )

    # Converte a string em um array de bytes em UTF-8.
    # O SHA-1 só funciona com bytes, por isso essa conversão é necessária.
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)

    # cria o hash.
    $sha1  = [System.Security.Cryptography.SHA1]::Create()

    # Gera o hash binário (array de bytes).
    $hash  = $sha1.ComputeHash($bytes)

    # retorna o hash em hexadecimal
    return (
        $hash |
        # Dentro do bloco { ... }, o conteúdo atual do pipeline fica armazenado na variável $_.
        # Cada byte é convertido para hexadecimal de dois dígitos
        ForEach-Object { $_.ToString("x2") }
    # Junta todos os hexadecimais numa única string:
    ) -join ""
}

Get-SHA1 "Hello, Git"