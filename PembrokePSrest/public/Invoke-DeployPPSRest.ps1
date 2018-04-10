function Invoke-DeployPPSRest
{
    <#
	.DESCRIPTION
		Deploy Database Schema to web server. This needs to be updated
    .PARAMETER InstallDirectory
        A valid Directory is optional.
    .PARAMETER SourceAvailableRoutesDirectory
        A valid Directory is optional.
    .PARAMETER SourceAvailableRoutesFile
        A valid File is optional.
	.EXAMPLE
        Invoke-DeployPPSRest -InstallDirectory C:\PembrokePS\Rest -SourceAvailableRoutesDirectory C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data -SourceAvailableRoutesFile C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1
	.NOTES
        It will create the directory if it does not exist.
    #>
    [CmdletBinding()]
    [OutputType([boolean])]
    param(
        [String]$InstallDirectory = 'C:\PembrokePS\Rest',
        [String]$SourceAvailableRoutesDirectory = ((Split-Path -Path (Get-Module -ListAvailable PembrokePSrest).path) + "\Data"),
        [String]$SourceAvailableRoutesFile = '\PembrokePS\EndpointRoutes.ps1'
    )
    try
    {       
        #$SourceAvailableRoutesFile = $SourceAvailableRoutesDirectory + $SourceAvailableRoutesFile
        if (Invoke-CreateRouteDirectorySet -InstallDirectory $InstallDirectory)
        {
            Write-Output "Invoke-CreateRouteDirectorySet complete successfully."
        }
        if (Invoke-MoveEndpointRouteSet -InstallDirectory $InstallDirectory -SourceAvailableRoutesDirectory $SourceAvailableRoutesDirectory)
        {
            Write-Output "Invoke-MoveEndpointRouteSet complete successfully."
        }
        # Move \bin files to Install Directory
        $SourceBinDirectory = ((Split-Path -Path (Get-Module -ListAvailable PembrokePSrest).path) + "\bin")
        if(Copy-Item -Path $SourceBinDirectory -Destination $InstallDirectory -Container -Recurse -Force -Confirm:$false){
            Write-Output "Copied \bin successfully."
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Invoke-DeployPPSRest: $ErrorMessage $FailedItem"
    }

}