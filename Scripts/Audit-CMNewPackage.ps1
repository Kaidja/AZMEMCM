Param(
    $User,
    $PackageID,
    $Time = (Get-Date)
)


Function Get-CMProvider
{
    Get-CimInstance -Namespace 'root\SMS' -Class 'SMS_ProviderLocation'
}


###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMNewPackage.log"

$CMProviderInfo = Get-CMProvider

$PackageQuery = Get-CimInstance -Namespace $CMProviderInfo.NamespacePath -ClassName "SMS_PackageBaseclass" -Filter "PackageID='$PackageID'" | Get-CimInstance
$PackageID = $PackageQuery.PackageID
$PackageType = $PackageQuery.PackageType
$PackageName = $PackageQuery.Name

Import-Module PSEventViewer

$EventDetails = @{
    LogName = 'ConfigurationManager'
    EntryType = 'Information'
    ID = 30000
    Source = 'ConfigurationManager'
    AdditionalFields = $User,$PackageID,$PackageType,$PackageName
    Message = "User $User created a new package"
}

Write-Event @EventDetails

Stop-Transcript