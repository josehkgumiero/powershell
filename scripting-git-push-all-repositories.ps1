# Diretório raiz que contém os repositórios
$diretorioRaiz = "c:\Users\User\Desktop"
$diretorioRaiz

# Mensagem do commit (com data e hora)
$commitMessage = "Atualização automática - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$commitMessage

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Iniciando varredura em: $diretorioRaiz" -ForegroundColor Yellow

# Obtém dinamicamente todas as subpastas
$repositorios = Get-ChildItem -Path $diretorioRaiz -Directory
$repositorios

foreach ($repo in $repositorios) {

    $repoPath = $repo.FullName

    Write-Host "------------------------------------------" -ForegroundColor Cyan
    Write-Host "Verificando: $repoPath" -ForegroundColor Yellow

    # Verifica se é um repositório Git
    if (-not (Test-Path "$repoPath\.git")) {
        Write-Host "Não é um repositório Git. Pulando..." -ForegroundColor DarkYellow
        continue
    }

    Set-Location $repoPath

    # Verifica se há alterações (novos arquivos ou modificações)
    $status = git status --porcelain
    $status

    if (-not $status) {
        Write-Host "Nenhuma alteração detectada." -ForegroundColor Green
        continue
    }

    try {
        # Adiciona novos arquivos e alterações
        git add .
        # Commit
        git commit -m "$commitMessage"
        # Push para a branch atual
        git push -u origin main
        Write-Host "Commit e push realizados com sucesso!" -ForegroundColor Green
        cd ..
        cd '.\powershell\'
    }
    catch {
        Write-Host "Erro ao processar $repoPath" -ForegroundColor Red
        Write-Host $_
    }
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Processo finalizado para todos os repositórios." -ForegroundColor Green
