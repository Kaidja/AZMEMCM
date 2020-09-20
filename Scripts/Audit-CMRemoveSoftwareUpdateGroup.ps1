Param(
    $User,
    $SWGroupID,
    $Time = (Get-Date)
)

###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMRemoveSoftwareUpdateGroup.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30221
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$SWGroupID
    Message = "User $User removed a new Software Update Group: $SWGroupID"
}

Write-Event @EventDetails

Stop-Transcript