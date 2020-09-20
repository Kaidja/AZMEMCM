Param(
    $User,
    $ApplicationName,
    $Collection,
    $Time = (Get-Date)
)



###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMNewApplicationDeployment.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30226
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$ApplicationName,$Collection
    Message = "User $User deployed new Application"
}

Write-Event @EventDetails

Stop-Transcript