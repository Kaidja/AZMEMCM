#Modify variables based on your environment
$ScriptLocation = "F:\AZMEMCM"
$SiteCode = "PS1"

# Connect to Configuration Manager
If((Get-Module ConfigurationManager) -eq $null) {
    Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1"
}
If((Get-PSDrive -Name $SiteCode -PSProvider CMSite -ErrorAction SilentlyContinue) -eq $null) {
    New-PSDrive -Name $SiteCode -PSProvider CMSite -Root $SiteServer 
}

Set-Location "$($SiteCode):\" 

#Somebody added a new user  / group - EventID 31240
New-CMStatusFilterRule `
    -Name "Detection - Change in Administrative Users - Add" `
    -MessageId 31240 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMNewAdministrator.ps1 -User ""%msgis01"" -UserOrGroup ""%msgis03"" -Roles ""%msgis04"" -Collections ""%msgis06"" -Scopes ""%msgis05"""

#Somebody removed a new user  / group - EventID 31242
New-CMStatusFilterRule `
    -Name "Detection - Change in Administrative Users - Remove" `
    -MessageId 31242 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMRemovedAdministrator.ps1 -User ""%msgis01"" -UserOrGroup ""%msgis03"" -Roles ""%msgis04"" -Collections ""%msgis06"" -Scopes ""%msgis05"""

#Somebody changed Client Agent Settings - EventID 30043
New-CMStatusFilterRule `
    -Name "Detection - Change in Client Settings" `
    -MessageId 30043 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMClientSettingChange.ps1 -User ""%msgis01"" -ClientSetting ""%msgis05"""

#New Application deployment - EventID 30226
New-CMStatusFilterRule `
    -Name "Detection - New Application Deployment" `
    -MessageId 30226 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMNewApplicationDeployment.ps1 -User ""%msgis01"" -ApplicationName ""%msgis03"" -Collection ""%msgis04"""

#Site Configuration change - EventID 30031
New-CMStatusFilterRule `
    -Name "Detection - Change in Site Configuration" `
    -MessageId 30031 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMSiteSettingsChange.ps1 -User ""%msgis01"" -SiteName ""%msgis06"""

#New Security Role - EventID 31200
New-CMStatusFilterRule `
    -Name "Detection - New Security Role - Add" `
    -MessageId 31200 `
    -ReportToEventLog $True `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMNewSecurityRole.ps1 -User ""%msgis01"" -SecurityRoleName ""%msgis03"""

#New Script - EventID 52500
New-CMStatusFilterRule `
    -Name "Detection - New Script - Add" `
    -MessageId 52500 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMNewScripts.ps1 -User ""%msgis01"" -ScriptGUID %msgis02"

#Script Execution against devices - EventID 40806
New-CMStatusFilterRule `
    -Name "Detection - Script Execution against Devices" `
    -MessageId 40806 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMScriptExecution.ps1 -User ""%msgis01"" -ScriptGUID ""%msgis03"" -DeviceCount %msgis06"

#New Package - EventID 30000
New-CMStatusFilterRule `
    -Name "Detection - New Package - Add" `
    -MessageId 30000 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMNewPackage.ps1 -User ""%msgis01"" -PackageID ""%msgis02"""
    
#Edit Script - EventID 52506
New-CMStatusFilterRule `
    -Name "Detection - New Script - Edit" `
    -MessageId 52506 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMEditScript.ps1 -User ""%msgis01"" -ScriptGUID %msgis02"

#Script Approved - EventID 52501
New-CMStatusFilterRule `
    -Name "Detection - New Script - Approved" `
    -MessageId 52501 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMApprovedScript.ps1 -User ""%msgis01"" -ScriptGUID %msgis02"

#Collection Add - EventID 30015
New-CMStatusFilterRule `
    -Name "Detection - Collection - Add" `
    -MessageId 30015 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMNewCollection.ps1 -User ""%msgis01"" -CollectionID %msgis02 -CollectionName ""%msgis03"""

#Collection Change - EventID 30016
New-CMStatusFilterRule `
    -Name "Detection - Collection - Change" `
    -MessageId 30016 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMCollectionChange.ps1 -User ""%msgis01"" -CollectionID %msgis02 -CollectionName ""%msgis03"""

#Collection Remove - EventID 30017
New-CMStatusFilterRule `
    -Name "Detection - Collection - Remove" `
    -MessageId 30017 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMRemoveCollection.ps1 -User ""%msgis01"" -CollectionID %msgis02 -CollectionName ""%msgis03"""

#Task Sequence change - EventID 30001
New-CMStatusFilterRule `
    -Name "Detection - Change in Task Sequnce" `
    -MessageId 30001 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMTaskSequenceChange.ps1 -User ""%msgis01"" -TaskSequenceID %msgis02 -TaskSequenceName ""%msgis03"""

#New Software Update Group - EventID 30219
New-CMStatusFilterRule `
    -Name "Detection - Software Update Group - Add" `
    -MessageId 30219 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMNewSoftwareUpdateGroup.ps1 -User ""%msgis01"" -SWGroupID ""%msgis02"""

#Remove Software Update Group - EventID 30221
New-CMStatusFilterRule `
    -Name "Detection - Software Update Group - Remove" `
    -MessageId 30221 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMRemoveSoftwareUpdateGroup.ps1 -User ""%msgis01"" -SWGroupID ""%msgis02"""

#All Other Deployment types - EventID 30196
New-CMStatusFilterRule `
    -Name "Detection - All Other Deployment Types" `
    -MessageId 30196 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMOtherDeploymentTypes.ps1 -User ""%msgis01"" -DeploymentID %msgis02 -DeploymentName ""%msgis04"""

#New Remote Control Session Start - EventID 30076
New-CMStatusFilterRule `
    -Name "Detection - Remote Control Session - Start" `
    -MessageId 30076 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMRemoteControlStart.ps1 -User ""%msgis01"" -SourceComputer ""%msgis02"" -TargetComputer ""%msgis03"" -ProcessID %msgpid -ThreadID %msgtid"

#New Remote Control Session End - EventID 30077
New-CMStatusFilterRule `
    -Name "Detection - Remote Control Session - End" `
    -MessageId 30077 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMRemoteControlEnd.ps1 -User ""%msgis01"" -SourceComputer ""%msgis02"" -TargetComputer ""%msgis03"" -ProcessID %msgpid -ThreadID %msgtid"

#Script Execution against Collections - EventID 40805
New-CMStatusFilterRule `
    -Name "Detection - Script Execution against Collection" `
    -MessageId 40805 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMScriptExecutionAgainstCollection.ps1 -User ""%msgis01"" -ScriptGUID ""%msgis03"" -CollectionID %msgis05"

#Remove a Device - EventID 30066
New-CMStatusFilterRule `
    -Name "Detection - Remove Device" `
    -MessageId 30066 `
    -ReportToEventLog $False `
    -RunProgram $True `
    -ProgramPath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File $ScriptLocation\Audit-CMRemoveDevice.ps1 -User ""%msgis01"" -DeviceName ""%msgis03"" -ResourceID ""%msgis02"""