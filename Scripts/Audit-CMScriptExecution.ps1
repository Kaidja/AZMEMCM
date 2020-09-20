Param(
    $User,
    $ScriptGUID,
    $DeviceCount,
    $Time = (Get-Date)
)


Function Get-CMProvider
{
    Get-CimInstance -Namespace 'root\SMS' -Class 'SMS_ProviderLocation'
}


###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMScriptExecution.log"

$CMProviderInfo = Get-CMProvider

$ScriptQuery = Get-CimInstance -Namespace $CMProviderInfo.NamespacePath -ClassName "SMS_Scripts" -Filter "ScriptGuid='$ScriptGUID'" | Get-CimInstance
$ScriptContent = $ScriptQuery.Script
$ScriptName = $ScriptQuery.ScriptName

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 40806
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$ScriptGUID,$Time,$ScriptContent,$ScriptName,$DeviceCount
    Message = "User $User executed script against devices"
}

Write-Event @EventDetails

Stop-Transcript