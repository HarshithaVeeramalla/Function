# This script lists outs Azure Function apps that are running on the v3 version of the host so they can be upgraded  
# Review https://learn.microsoft.com/en-us/azure/azure-functions/migrate-version-3-version-4 for details on how to upgrade to ~4 of the runtime 
 
$Subscription = '<YOUR SUBSCRIPTION ID>' 
 
Set-AzContext -Subscription $Subscription | Out-Null

$FunctionApps = Get-AzFunctionApp

$AppInfo = @{}

foreach ($App in $FunctionApps)
{
     if ($App.ApplicationSettings["FUNCTIONS_EXTENSION_VERSION"] -like '*3*')
     {
          $AppInfo.Add($App.Name, $App.ApplicationSettings["FUNCTIONS_EXTENSION_VERSION"])
     }
}

$AppInfo
$AppInfo.Count

$AppInfo | Export-Csv -Path "$PSScriptRoot\YourEOLApps.csv" -NoTypeInformation