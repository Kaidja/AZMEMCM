Param(
    $User,
    $TaskSequenceID,
    $TaskSequenceName,
    $Time = (Get-Date)
)


###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMTaskSequenceChange.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30001
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$TaskSequenceID,$TaskSequenceName
    Message = "User $User changed the Task Sequence: $TaskSequenceName"
}

Write-Event @EventDetails

Stop-Transcript