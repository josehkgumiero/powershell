<#
.SYNOPSIS
Automated Git commit and push for multiple repositories.

.DESCRIPTION
Searches for Git repositories starting from the current directory.
If none are found, walks up parent directories until repositories are located.
Also ensures Git global configuration is defined.

.AUTHOR
José Henrique Krugner Gumiero

.VERSION
2.0.0
#>

# =========================
# Logger Class
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
# Git Configuration Manager
# =========================
class GitConfigManager {

    [Logger]$Logger
    [string]$UserName
    [string]$UserEmail

    GitConfigManager(
        [string]$userName,
        [string]$userEmail,
        [Logger]$logger
    ) {
        $this.UserName = $userName
        $this.UserEmail = $userEmail
        $this.Logger = $logger
    }

    [void] EnsureGitIdentity() {

        $this.Logger.Info("Checking Git global configuration...")

        $existingName = git config --global user.name
        $existingEmail = git config --global user.email

        if (-not $existingName) {

            $this.Logger.Warn("Git user.name not configured. Setting it now.")
            git config --global user.name $this.UserName

        }
        else {

            $this.Logger.Info("Git user.name already configured: $existingName")

        }

        if (-not $existingEmail) {

            $this.Logger.Warn("Git user.email not configured. Setting it now.")
            git config --global user.email $this.UserEmail

        }
        else {

            $this.Logger.Info("Git user.email already configured: $existingEmail")

        }

        $this.Logger.Info("Git identity configuration completed.")
    }
}

# =========================
# Git Repository Locator
# =========================
class GitRepositoryLocator {

    [Logger]$Logger

    GitRepositoryLocator([Logger]$logger) {
        $this.Logger = $logger
    }

    [string] FindRootDirectory() {

        [System.IO.DirectoryInfo]$current = Get-Item (Get-Location).Path

        while ($true) {

            $this.Logger.Info("Checking directory: $($current.FullName)")

            $repos = Get-ChildItem $current.FullName -Directory |
                Where-Object { Test-Path "$($_.FullName)\.git" }

            if ($repos.Count -gt 0) {

                $this.Logger.Info("Git repositories found in:")
                $this.Logger.Info($current.FullName)

                foreach ($repo in $repos) {
                    $this.Logger.Info(" -> $($repo.Name)")
                }

                return $current.FullName
            }

            if ($null -eq $current.Parent) {
                throw "No Git repositories found in current or parent directories."
            }

            $this.Logger.Warn("No repositories found. Moving to parent directory.")

            $current = $current.Parent
        }

        return $null
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

        $this.Logger.Info("==========================================")
        $this.Logger.Info("Scanning repositories in:")
        $this.Logger.Info($this.RootDirectory)
        $this.Logger.Info("Commit message:")
        $this.Logger.Info("-> $($this.CommitMessage)")
        $this.Logger.Info("==========================================")

        if (-not (Test-Path $this.RootDirectory)) {
            throw "Root directory not found: $($this.RootDirectory)"
        }

        $repositories = Get-ChildItem -Path $this.RootDirectory -Directory

        foreach ($repo in $repositories) {
            $this.ProcessSingleRepository($repo.FullName)
        }

        $this.Logger.Info("Repository scan completed.")
    }

    [void] ProcessSingleRepository([string]$repoPath) {

        $this.Logger.Info("------------------------------------------")
        $this.Logger.Info("Checking repository: $repoPath")

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

            $this.CommitAndPush($repoPath)

        }
        catch {

            $this.Logger.Error("Failed to process repository: $repoPath")
            $this.Logger.Error($_.Exception.Message)

        }
        finally {

            Pop-Location

        }
    }

    [void] CommitAndPush([string]$repoPath) {

        try {

            $this.Logger.Info("Changes detected.")
            $this.Logger.Info("Using commit message:")
            $this.Logger.Info("-> $($this.CommitMessage)")

            git add .
            git commit -m $this.CommitMessage
            git push -u origin main

            $this.Logger.Info("Commit and push completed successfully:")
            $this.Logger.Info("[OK] $repoPath")

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

    $logger = [Logger]::new("GitAutoCommit")

    $logger.Info("Initializing automated Git commit process")

    # Configure Git identity
    $userName = "josehkgumiero"
    $userEmail = "jose_hkg@hotmail.com"

    $configManager = [GitConfigManager]::new(
        $userName,
        $userEmail,
        $logger
    )

    $configManager.EnsureGitIdentity()

    # Locate repositories automatically
    $locator = [GitRepositoryLocator]::new($logger)
    $rootDirectory = $locator.FindRootDirectory()

    # Dynamic commit message
    $commitMessage = "Automated update - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

    $processor = [GitRepositoryProcessor]::new(
        $rootDirectory,
        $commitMessage,
        $logger
    )

    $processor.ProcessAllRepositories()

    $logger.Info("==========================================")
    $logger.Info("All repositories processed successfully.")

}
catch {

    Write-Host "[FATAL] $($_.Exception.Message)" -ForegroundColor Red

}