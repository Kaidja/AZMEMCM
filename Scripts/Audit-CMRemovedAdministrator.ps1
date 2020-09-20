﻿Param(
    $User,
    $UserOrGroup,
    $Scopes,
    $Collections,
    $Roles,
    $Time = (Get-Date)
)

###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMRemovedAdministrator.log"

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 31242
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$UserOrGroup,$Roles,$Scopes,$Collections,$Time
    Message = "User $User changed security settings."
}

Write-Event @EventDetails

Stop-Transcript