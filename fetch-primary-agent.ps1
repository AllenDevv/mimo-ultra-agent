# Fetch primary agent from configured GitHub repo and copy into workspace root
$ErrorActionPreference = 'Stop'
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$configFile = Join-Path $scriptDir '.primary-agent'
if (-not (Test-Path $configFile)) {
    Write-Host "Config file .primary-agent not found. Exiting."
    exit 1
}
$configLines = Get-Content $configFile | Where-Object { $_ -and -not $_.TrimStart().StartsWith('#') }
$config = @{}
foreach ($line in $configLines) {
    $parts = $line -split '[:=]',2
    if ($parts.Length -eq 2) {
        $key = $parts[0].Trim()
        $val = $parts[1].Trim()
        $config[$key] = $val
    }
}
$repoUrl = $config['primary_agent_repo']
$agentPath = $config['primary_agent_path']
$localDir = Join-Path $scriptDir '.primary-agent-repo'
if (-not (Test-Path $localDir)) {
    Write-Host "Cloning $repoUrl to $localDir"
    git clone $repoUrl $localDir
} else {
    Write-Host "Pulling latest in $localDir"
    git -C $localDir pull --quiet
}
$src = Join-Path $localDir $agentPath
if (-not (Test-Path $src)) {
    Write-Host "Agent file '$agentPath' not found in repo. Exiting with error."
    exit 2
}
$dest = Join-Path $scriptDir $agentPath
Copy-Item -Path $src -Destination $dest -Force
Write-Host "Copied $src -> $dest"
