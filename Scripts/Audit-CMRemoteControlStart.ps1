Param(
    $User,
    $SourceComputer,
    $TargetComputer,
    $ProcessID,
    $ThreadID,
    $Time = (Get-Date)
)

###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMRemoteControlStart.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30076
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$SourceComputer,$TargetComputer,$ProcessID,$ThreadID
    Message = "User $User at $SourceComputer initiated Remote Control with $TargetComputer"
}

Write-Event @EventDetails

Stop-Transcript