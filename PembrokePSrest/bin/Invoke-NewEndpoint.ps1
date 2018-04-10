<#
.DESCRIPTION
	This Script will Execute a specified task, and submit any needed subtasks.
.PARAMETER SourceAvailableRoutesFile
	A Rest PropertyFilePath is required.
.PARAMETER Port
	A Rest PropertyFilePath is required.
.EXAMPLE
	Start-Process -WindowStyle Normal powershell.exe -ArgumentList "-file Invoke-NewEndpoint.ps1", "-SourceAvailableRoutesFile $SourceAvailableRoutesFile -Port $Port"
.NOTES
	This will start a new PembrokePS Endpoint.
#>
param(
	[Parameter(Mandatory=$true)][String]$SourceAvailableRoutesFile,
	[Parameter(Mandatory=$true)][Int]$Port
)
# Import required Modules
Import-Module -Name PowerLumber,RestPS -Force
try 
{
    if (Test-Path -Path $SourceAvailableRoutesFile)
    {
		$Host.UI.RawUI.WindowTitle = "PembrokePS Endpoint Port:$Port"
		Start-RestPSListener -Port $Port -RoutesFilePath $SourceAvailableRoutesFile
    }
    else 
    {
        Throw "Invoke-NewEndpoint: Routes File: $SourceAvailableRoutesFile does not exist."
    }
}
catch
{
	$ErrorMessage = $_.Exception.Message
	$FailedItem = $_.Exception.ItemName		
	Throw "Invoke-NewEndpoint: $ErrorMessage $FailedItem"
}