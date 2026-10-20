# Remove the scheduled task created by enable-primary-agent-task.ps1
$taskName = 'FetchPrimaryAgent'
try {
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction Stop
        Write-Host "Scheduled task '$taskName' unregistered."
    } else {
        Write-Host "Scheduled task '$taskName' not found."
    }
} catch {
    Write-Host "Failed to unregister scheduled task: $_"
}
