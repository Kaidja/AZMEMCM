Param(
    $User,
    $SiteName,
    $Time = (Get-Date)
)



###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMSiteSettingsChange.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30031
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$SiteName
    Message = "User $User changed Primary Site settings"
}

Write-Event @EventDetails

Stop-Transcript