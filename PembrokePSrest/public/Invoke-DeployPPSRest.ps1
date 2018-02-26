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
        [String]$SourceAvailableRoutesDirectory = 'C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data',
        [String]$SourceAvailableRoutesFile = 'C:\OPEN_PROJECTS\ProjectPembroke\PembrokePSrest\PembrokePSrest\data\PembrokePSEndpointRoutes.ps1'
    )
    try
    {
        Invoke-CreateRouteDirectories -InstallDirectory $InstallDirectory
        Invoke-MoveEndpointRoutes -InstallDirectory $InstallDirectory -SourceAvailableRoutesDirectory $SourceAvailableRoutesDirectory
        Invoke-MoveAvailableRoutesFile -InstallDirectory $InstallDirectory -SourceAvailableRoutesFile $SourceAvailableRoutesFile
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Write-Error "Error: $ErrorMessage $FailedItem"
        Throw $_
    }

}