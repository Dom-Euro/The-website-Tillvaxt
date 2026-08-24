param(
  [string]$RepoPath = ".",
  [string]$RemoteUrl = "https://github.com/Dom-Euro/The-website-Tillvaxt.git",
  [string]$Branch = "main",
  [int]$DebounceMs = 5000
)

Set-Location $RepoPath

# Ensure Git is initialized and remote is set
if (-not (Test-Path (Join-Path $RepoPath '.git'))) {
  Write-Output "Git repository not found — initializing..."
  git init
  git add -A
  git commit -m "Initial commit" 2>$null
  git branch -M $Branch 2>$null
  git remote add origin $RemoteUrl 2>$null
  try {
    git push -u origin $Branch
  } catch {
    Write-Output "Initial push failed (auth or network). Configure auth (SSH/PAT) and push manually."    
  }
} else {
  # Ensure remote URL matches requested remote (set if missing)
  $remotes = git remote -v 2>$null
  if ($remotes -notmatch "origin") {
    git remote add origin $RemoteUrl 2>$null
  } else {
    # update origin URL if different
    $current = git remote get-url origin 2>$null
    if ($current -and $current -ne $RemoteUrl) {
      git remote set-url origin $RemoteUrl 2>$null
    }
  }
}

Write-Output "Watching path: $(Resolve-Path $RepoPath) — remote: $RemoteUrl (branch: $Branch)"

$fsw = New-Object System.IO.FileSystemWatcher $RepoPath -Property @{IncludeSubdirectories = $true; EnableRaisingEvents = $true}
$timer = New-Object Timers.Timer $DebounceMs
$timer.AutoReset = $false
$global:changed = $false

$handler = {
  $global:changed = $true
  $timer.Stop()
  $timer.Start()
}

$changedEvent = Register-ObjectEvent $fsw Changed -Action $handler
$createdEvent = Register-ObjectEvent $fsw Created -Action $handler
$deletedEvent = Register-ObjectEvent $fsw Deleted -Action $handler
$renamedEvent = Register-ObjectEvent $fsw Renamed -Action $handler

$timer.add_Elapsed({
  if ($global:changed) {
    Write-Output "Changes detected — preparing commit..."
    git add -A
    $status = git status --porcelain
    if ($status) {
      $msg = "Auto-update $(Get-Date -Format o)"
      git commit -m $msg
      try {
        git push origin $Branch
        Write-Output "Pushed to origin/$Branch"
      } catch {
        Write-Output "Push failed. Check authentication or network."
      }
    } else {
      Write-Output "No staged changes to commit."
    }
    $global:changed = $false
  }
})

Write-Output "Press Ctrl+C or Enter to stop watching."
try {
  # Keep process alive until user presses Enter
  [Console]::ReadLine() | Out-Null
} finally {
  Unregister-Event -SourceIdentifier $changedEvent.Name, $createdEvent.Name, $deletedEvent.Name, $renamedEvent.Name -ErrorAction SilentlyContinue
  $fsw.EnableRaisingEvents = $false
}
