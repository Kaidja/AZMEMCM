Param(
    $User,
    $DeploymentID,
    $DeploymentName,
    $Time = (Get-Date)
)

Function Get-CMProvider
{
    Get-CimInstance -Namespace 'root\SMS' -Class 'SMS_ProviderLocation'
}

###########################  SCRIPT ENTRY POINT ##############################################

Start-Transcript -Path "$PSScriptRoot\Logs\Audit-CMOtherDeploymentTypes.log"

Import-Module PSEventViewer

$CMProviderInfo = Get-CMProvider

$DeploymentTypeInfo = Get-WmiObject -Namespace ($CMProviderInfo.NamespacePath).Replace("\\$($CMProviderInfo.Machine)\","") -Class "SMS_DeploymentSummary" -Filter "AssignmentID='$DeploymentID'" 

Switch($DeploymentTypeInfo.FeatureType){
    
    5 {
        #Software Updates
        $FeatureType = "Software Update"
        $SWGroupDeploymentQuery = Get-WmiObject -Namespace ($CMProviderInfo.NamespacePath).Replace("\\$($CMProviderInfo.Machine)\","") -Class "SMS_UpdateGroupAssignment" -Filter "AssignmentID='$DeploymentID'" | ForEach-Object {$_.Get(); $_}
        $SWGroupID = $SWGroupDeploymentQuery.AssignedUpdateGroup
        $SWStartTime = $SWGroupDeploymentQuery.ConvertToDateTime($SWGroupDeploymentQuery.StartTime)
        $SWDeadline = $SWGroupDeploymentQuery.ConvertToDateTime($SWGroupDeploymentQuery.EnforcementDeadline)
        $TargetCollection = $SWGroupDeploymentQuery.TargetCollectionID

        $SWGroupQuery = Get-CimInstance -Namespace $CMProviderInfo.NamespacePath -ClassName "SMS_AuthorizationList" -Filter "CI_ID='$SWGroupID'" | Get-CimInstance
        $SWGroupName = $SWGroupQuery.LocalizedDisplayName

        $EventDetails = @{
            LogName = 'ConfigurationManager'
            EntryType = 'Information'
            ID = 30196
            Source = 'ConfigurationManager'
            AdditionalFields = $User,$SWGroupID,$SWGroupName,$DeploymentName,$SWStartTime,$SWDeadline,$TargetCollection,$FeatureType
            Message = "User $User deployed the following Software Update Group: $SWGroupName"
        }
    }

    6 {
        #Software Updates
        $FeatureType = "Baseline"
        $TargetCollection = $DeploymentTypeInfo.CollectionName
        $BaselineName = $DeploymentTypeInfo.SoftwareName

        $EventDetails = @{
            LogName = 'ConfigurationManager'
            EntryType = 'Information'
            ID = 30196
            Source = 'ConfigurationManager'
            AdditionalFields = $User,$BaselineName,$TargetCollection,$FeatureType
            Message = "User $User deployed the following Baseline: $BaselineName"
        }
    }

}

Write-Event @EventDetails

Stop-Transcript