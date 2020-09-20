Param(
    $User,
    $DeviceName,
    $ResourceID,
    $Time = (Get-Date)
)

###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMRemoveDevice.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30066
    Source = 'ConfigurationManager'
    AdditionalFields = $User, $DeviceName, $ResourceID, $Time
    Message = "User $User deleted a discovered resource named $DeviceName $ResourceID."
}

Write-Event @EventDetails

Stop-Transcript