Param(
    $User,
    $SWGroupID,
    $Time = (Get-Date)
)

Function Get-CMProvider
{
    Get-CimInstance -Namespace 'root\SMS' -Class 'SMS_ProviderLocation'
}

###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMNewSoftwareUpdateGroup.log"

$CMProviderInfo = Get-CMProvider

$SWGroupQuery = Get-CimInstance -Namespace $CMProviderInfo.NamespacePath -ClassName "SMS_AuthorizationList" -Filter "CI_ID='$SWGroupID'" | Get-CimInstance
$SWGroupName = $SWGroupQuery.LocalizedDisplayName

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30219
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$SWGroupID,$SWGroupName
    Message = "User $User created a new Software Update Group: $SWGroupName"
}

Write-Event @EventDetails

Stop-Transcript