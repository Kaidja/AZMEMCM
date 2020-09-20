Param(
    $User,
    $CollectionID,
    $CollectionName,
    $Time = (Get-Date)
)


###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMNewCollection.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30015
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$CollectionID,$CollectionName
    Message = "User $User created the Collection: $CollectionName"
}

Write-Event @EventDetails

Stop-Transcript
