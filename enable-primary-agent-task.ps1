# Enable scheduled task to run fetch-primary-agent.ps1 every 5 minutes
$ErrorActionPreference = 'Stop'
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$fetchScript = Join-Path $scriptDir 'fetch-primary-agent.ps1'
$taskName = 'FetchPrimaryAgent'
if (-not (Test-Path $fetchScript)) {
    Write-Host "fetch-primary-agent.ps1 not found at $fetchScript. Run this script from the workspace root."
    exit 1
}
try {
    $action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$fetchScript`""
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes 5) -RepetitionDuration ([TimeSpan]::MaxValue)
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Description "Fetch mimo-ultra.md every 5 minutes" -Force
    Write-Host "Scheduled task '$taskName' registered successfully."
} catch {
    Write-Host "Failed to register scheduled task: $_"
    Write-Host "You may need to run this script as Administrator. Alternatively, register a scheduled task manually that runs: PowerShell -NoProfile -ExecutionPolicy Bypass -File \"$fetchScript\" every 5 minutes."
}
