Param(
    $User,
    $CollectionID,
    $CollectionName,
    $Time = (Get-Date)
)


###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMRemoveCollection.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30017
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$CollectionID,$CollectionName
    Message = "User $User removed the Collection: $CollectionName"
}

Write-Event @EventDetails

Stop-Transcript
