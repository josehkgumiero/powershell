<#
.SYNOPSIS
    Automated Git commit and push for multiple repositories.

.DESCRIPTION
    This script scans a root directory, identifies Git repositories,
    checks for uncommitted changes, and automatically performs
    git add, commit, and push operations.

    Designed following software engineering best practices:
    - Object-Oriented Design
    - Centralized logging
    - Robust error handling
    - Clear separation of responsibilities

.AUTHOR
    José Henrique Krugner Gumiero

.VERSION
    1.0.0
#>

# =========================
# Logger class
# =========================
class Logger {

    [string]$Name

    Logger([string]$name) {
        $this.Name = $name
    }

    [void] Info([string]$message) {
        Write-Host "[INFO]  $message" -ForegroundColor Green
    }

    [void] Warn([string]$message) {
        Write-Host "[WARN]  $message" -ForegroundColor Yellow
    }

    [void] Error([string]$message) {
        Write-Host "[ERROR] $message" -ForegroundColor Red
    }
}

# =========================
# Git Repository Processor
# =========================
class GitRepositoryProcessor {

    [string]$RootDirectory
    [string]$CommitMessage
    [Logger]$Logger

    GitRepositoryProcessor(
        [string]$rootDirectory,
        [string]$commitMessage,
        [Logger]$logger
    ) {
        $this.RootDirectory = $rootDirectory
        $this.CommitMessage = $commitMessage
        $this.Logger = $logger
    }

    [void] ProcessAllRepositories() {

        $this.Logger.Info("Starting repository scan at: $($this.RootDirectory)")

        if (-not (Test-Path $this.RootDirectory)) {
            throw "Root directory not found: $($this.RootDirectory)"
        }

        $repositories = Get-ChildItem -Path $this.RootDirectory -Directory

        foreach ($repo in $repositories) {
            $this.ProcessSingleRepository($repo.FullName)
        }

        $this.Logger.Info("Repository processing finished.")
    }

    [void] ProcessSingleRepository([string]$repoPath) {

        $this.Logger.Info("Checking repository: $repoPath")

        # Validate Git repository
        if (-not (Test-Path "$repoPath\.git")) {
            $this.Logger.Warn("Not a Git repository. Skipping.")
            return
        }

        Push-Location $repoPath

        try {
            $status = git status --porcelain

            if (-not $status) {
                $this.Logger.Info("No changes detected.")
                return
            }

            $this.CommitAndPush()

        }
        catch {
            $this.Logger.Error("Failed to process repository: $repoPath")
            $this.Logger.Error($_.Exception.Message)
        }
        finally {
            Pop-Location
        }
    }

    [void] CommitAndPush() {

        try {
            $this.Logger.Info("Changes detected. Executing git workflow...")

            git add .
            git commit -m $this.CommitMessage
            git push -u origin main

            $this.Logger.Info("Commit and push completed successfully.")
        }
        catch {
            throw "Git operation failed: $($_.Exception.Message)"
        }
    }
}

# =========================
# Script Entry Point
# =========================
try {

    # Root directory containing repositories
    [string]$rootDirectory = "C:\Users\User\Desktop"

    # Dynamic commit message with timestamp
    [string]$commitMessage = "Automated update - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

    # Initialize logger
    $logger = [Logger]::new("GitAutoCommit")

    $logger.Info("==========================================")
    $logger.Info("Initializing automated Git commit process")
    $logger.Info("Root directory: $rootDirectory")

    # Initialize processor
    $processor = [GitRepositoryProcessor]::new(
        $rootDirectory,
        $commitMessage,
        $logger
    )

    # Run process
    $processor.ProcessAllRepositories()

    $logger.Info("==========================================")
    $logger.Info("All repositories processed successfully.")

}
catch {
    Write-Host "[FATAL] $($_.Exception.Message)" -ForegroundColor Red
}
