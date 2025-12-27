# =========================
# CONFIGURAÇÕES
# =========================

# Diretório raiz onde estão os repositórios
$diretorioRaiz = "C:\Projetos"

# Diretório de logs
$diretorioLogs = "$diretorioRaiz\logs"

# Cria diretório de logs se não existir
if (-not (Test-Path $diretorioLogs)) {
    New-Item -ItemType Directory -Path $diretorioLogs | Out-Null
}

# Arquivo de log com data
$logFile = "$diretorioLogs\git_automacao_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

# Mensagem base do commit
$commitMessageBase = "Atualização automática"

# =========================
# FUNÇÃO DE LOG
# =========================
function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logLine = "[$timestamp] [$Level] $Message"

    # Console
    switch ($Level) {
        "INFO"    { Write-Host $logLine -ForegroundColor Cyan }
        "SUCCESS" { Write-Host $logLine -ForegroundColor Green }
        "WARN"    { Write-Host $logLine -ForegroundColor Yellow }
        "ERROR"   { Write-Host $logLine -ForegroundColor Red }
        default   { Write-Host $logLine }
    }

    # Arquivo
    Add-Content -Path $logFile -Value $logLine
}

# =========================
# INÍCIO
# =========================
Write-Log "Iniciando automação Git"
Write-Log "Diretório raiz: $diretorioRaiz"
Write-Log "Arquivo de log: $logFile"

# Obtém subpastas dinamicamente
$repositorios = Get-ChildItem -Path $diretorioRaiz -Directory

foreach ($repo in $repositorios) {

    $repoPath = $repo.FullName
    Write-Log "Verificando pasta: $repoPath"

    # Verifica se é repositório Git
    if (-not (Test-Path "$repoPath\.git")) {
        Write-Log "Não é um repositório Git. Ignorado." "WARN"
        continue
    }

    Set-Location $repoPath

    # Verifica alterações
    $status = git status --porcelain 2>&1

    if (-not $status) {
        Write-Log "Nenhuma alteração encontrada." "INFO"
        continue
    }

    try {
        Write-Log "Alterações detectadas. Executando git add"
        git add . 2>&1 | Out-Null

        $commitMessage = "$commitMessageBase - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        Write-Log "Realizando commit: $commitMessage"
        git commit -m "$commitMessage" 2>&1 | Out-Null

        Write-Log "Executando push"
        git push 2>&1 | Out-Null

        Write-Log "Commit e push realizados com sucesso." "SUCCESS"
    }
    catch {
        Write-Log "Erro ao processar repositório $repoPath" "ERROR"
        Write-Log $_.Exception.Message "ERROR"
    }
}

Write-Log "Automação finalizada."
