Param(
    $User,
    $CollectionID,
    $CollectionName,
    $Time = (Get-Date)
)


###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMCollectionChange.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30016
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$CollectionID,$CollectionName
    Message = "User $User changed the Collection: $CollectionName"
}

Write-Event @EventDetails

Stop-Transcript