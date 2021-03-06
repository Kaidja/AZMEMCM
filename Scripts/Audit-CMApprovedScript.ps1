﻿Param(
    $User,
    $ScriptGUID,
    $Time = (Get-Date)
)


Function Get-CMProvider
{
    Get-CimInstance -Namespace 'root\SMS' -Class 'SMS_ProviderLocation'
}


###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMApprovedScript.log"

$CMProviderInfo = Get-CMProvider

$ScriptQuery = Get-CimInstance -Namespace $CMProviderInfo.NamespacePath -ClassName "SMS_Scripts" -Filter "ScriptGuid='$ScriptGUID'" | Get-CimInstance
$ScriptContent = $ScriptQuery.Script
$ScriptName = $ScriptQuery.ScriptName

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 52501
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$ScriptGUID,$Time,$ScriptContent,$ScriptName
    Message = "User $User approved the script with Guid $ScriptGUID."
}

Write-Event @EventDetails

Stop-Transcript
