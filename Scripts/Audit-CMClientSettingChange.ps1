Param(
    $User,
    $ClientSetting,
    $Time = (Get-Date)
)



###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMClientSettingChange.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30043
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$ClientSetting
    Message = "User $User changed Client Settings"
}

Write-Event @EventDetails

Stop-Transcript