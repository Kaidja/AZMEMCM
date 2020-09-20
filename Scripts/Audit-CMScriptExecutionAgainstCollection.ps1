Param(
    $User,
    $ScriptGUID,
    $CollectionID,
    $Time = (Get-Date)
)


Function Get-CMProvider
{
    Get-CimInstance -Namespace 'root\SMS' -Class 'SMS_ProviderLocation'
}


###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMScriptExecutionAgainstCollection.log"

$CMProviderInfo = Get-CMProvider

$ScriptQuery = Get-CimInstance -Namespace $CMProviderInfo.NamespacePath -ClassName "SMS_Scripts" -Filter "ScriptGuid='$ScriptGUID'" | Get-CimInstance
$ScriptContent = $ScriptQuery.Script
$ScriptName = $ScriptQuery.ScriptName

$CollectionQuery = Get-CimInstance -Namespace $CMProviderInfo.NamespacePath -ClassName "SMS_Collection" -Filter "CollectionID='$CollectionID'"
$CollectionName = $CollectionQuery.Name

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 40805
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$ScriptGUID,$Time,$ScriptContent,$ScriptName,$CollectionName,$CollectionID
    Message = "User $User executed script against $CollectionName Collection"
}

Write-Event @EventDetails

Stop-Transcript