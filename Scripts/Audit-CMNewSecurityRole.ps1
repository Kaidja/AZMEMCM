Param(
    $User,
    $SecurityRoleName,
    $Time = (Get-Date)
)



###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMNewSecurityRole.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 31200
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$SecurityRoleName
    Message = "User $User added a new Security Role"
}

Write-Event @EventDetails

Stop-Transcript